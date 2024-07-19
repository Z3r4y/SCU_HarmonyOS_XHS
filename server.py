from flask import Flask, jsonify, request, send_file, make_response
from flask_sqlalchemy import SQLAlchemy
import pymysql
from PIL import Image, ImageDraw, ImageFont
import random
import io
import base64

# 使用PyMySQL代替MySQLdb
pymysql.install_as_MySQLdb()

app = Flask(__name__)

# 配置MySQL数据库连接
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:my-secret-pw@124.222.136.33/xhs'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class ResponseData:
    def __init__(self, code=None, msg=None, data=None):
        self.code = code
        self.msg = msg
        self.data = data


class UserModel(db.Model):
    __tablename__ = 'users'
    uid = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80))
    user_number = db.Column(db.String(20))
    description = db.Column(db.String(255))
    following = db.Column(db.Integer)
    followers = db.Column(db.Integer)
    likes = db.Column(db.Integer)
    userphone = db.Column(db.String(20))
    password = db.Column(db.String(80))
    token = db.Column(db.String(255), nullable=True)

    def __init__(self, username, password, userphone, user_number=None, description=None, following=0, followers=0, likes=0, token=None):
        self.username = username
        self.password = password
        self.userphone = userphone
        self.user_number = user_number
        self.description = description
        self.following = following
        self.followers = followers
        self.likes = likes
        self.token = token



class HistoryModel(db.Model):
    __tablename__ = 'history'
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(255))

    def __init__(self, content):
        self.content = content


class SuggestionModel(db.Model):
    __tablename__ = 'suggestions'
    id = db.Column(db.Integer, primary_key=True)
    suggestion = db.Column(db.String(255))

    def __init__(self, suggestion):
        self.suggestion = suggestion


class HotTopicModel(db.Model):
    __tablename__ = 'hottopics'
    id = db.Column(db.Integer, primary_key=True)
    rank = db.Column(db.Integer)
    title = db.Column(db.String(255))
    views = db.Column(db.String(255))
    isHot = db.Column(db.Boolean)

    def __init__(self, rank, title, views, isHot):
        self.rank = rank
        self.title = title
        self.views = views
        self.isHot = isHot


class ItemModel(db.Model):
    __tablename__ = 'items'
    id = db.Column(db.Integer, primary_key=True)
    item = db.Column(db.String(255))

    def __init__(self, item):
        self.item = item

class PostModel(db.Model):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255))
    author = db.Column(db.String(255))
    image_url = db.Column(db.String(255))

    def __init__(self, title, author, image_url):
        self.title = title
        self.author = author
        self.image_url = image_url


def generate_captcha():
    # 创建一个白色背景的图像
    image = Image.new('RGB', (150, 60), (255, 255, 255))
    draw = ImageDraw.Draw(image)
    font = ImageFont.truetype('arial.ttf', 36)

    # 生成随机的验证码文本
    captcha_text = ''.join(random.choices('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', k=4))

    # 绘制验证码文本
    for i, char in enumerate(captcha_text):
        # 随机颜色
        color = (random.randint(0, 100), random.randint(0, 100), random.randint(0, 100))
        # 随机位置
        position = (10 + i * 30 + random.randint(-5, 5), random.randint(-5, 5))
        draw.text(position, char, font=font, fill=color)

    # 添加一些干扰线
    for _ in range(5):
        start = (random.randint(0, 150), random.randint(0, 60))
        end = (random.randint(0, 150), random.randint(0, 60))
        color = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
        draw.line([start, end], fill=color, width=2)

    # 添加一些噪点
    for _ in range(50):
        position = (random.randint(0, 150), random.randint(0, 60))
        color = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
        draw.point(position, fill=color)

    # 保存图像到内存中
    buffer = io.BytesIO()
    image.save(buffer, format='PNG')
    buffer.seek(0)
    img_base64 = base64.b64encode(buffer.getvalue()).decode('utf-8')

    return captcha_text, img_base64

@app.route('/api/captcha', methods=['GET'])
def get_captcha():
    captcha_text, img_base64 = generate_captcha()
    return jsonify({'captcha_text': captcha_text, 'captcha_image': img_base64})

@app.route('/user/login', methods=['POST'])
def user_login():
    data = request.json
    phone_number = data.get('userphone')
    password = data.get('password')

    user = UserModel.query.filter_by(userphone=phone_number, password=password).first()

    if user:
        # 生成一个token，这里使用简单的示例，你可以使用更复杂的生成方法
        token = generate_token(user.uid)
        user.token = token
        db.session.commit()
        response_data = ResponseData(code=0, msg='Success', data={
            'uid': user.uid,
            'username': user.username,
            'userphone': user.userphone,
            'token': token
        })
    else:
        response_data = ResponseData(code=1, msg='Invalid phone number or password')

    return jsonify(response_data.__dict__)

@app.route('/user/reg', methods=['POST'])
def user_register():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    userphone = data.get('userphone')
    sms_code = data.get('smsCode')

    if not username or not password or not userphone or not sms_code:
        response_data = ResponseData(code=400, msg='All fields are required')
        return jsonify(response_data.__dict__), 400

    if UserModel.query.filter_by(userphone=userphone).first():
        response_data = ResponseData(code=409, msg='Phone number already registered')
        return jsonify(response_data.__dict__), 409

    # 首先创建用户，不生成 token
    new_user = UserModel(username=username, password=password, userphone=userphone)
    db.session.add(new_user)
    db.session.commit()

    # 生成 token
    token = generate_token(new_user.uid)
    new_user.token = token
    db.session.commit()

    response_data = ResponseData(code=0, msg='Registration successful', data={
        'uid': new_user.uid,
        'username': new_user.username,
        'userphone': new_user.userphone,
        'token': token
    })

    return jsonify(response_data.__dict__), 200

def generate_token(uid):
    # 简单生成 token 的方法，可以用更安全的方式生成 token
    return base64.b64encode(f'token-{uid}'.encode()).decode()


@app.route('/user/profile', methods=['GET'])
def get_user_profile():
    token = request.args.get('token')
    user_id = get_user_id_from_token(token)
    user = UserModel.query.filter_by(uid=user_id).first()

    if user:
        response_data = ResponseData(code=0, msg='Success', data={
            'username': user.username,
            'user_number': user.user_number,
            'description': user.description,
            'following': user.following,
            'followers': user.followers,
            'likes': user.likes
        })
    else:
        response_data = ResponseData(code=1, msg='User not found')

    return jsonify(response_data.__dict__)

def get_user_id_from_token(token):
    # 解析 token 获取用户 ID 的逻辑
    decoded_token = base64.b64decode(token).decode()
    uid = int(decoded_token.split('-')[1])
    return uid

@app.route('/content/history', methods=['GET'])
def get_history():
    history_records = HistoryModel.query.all()
    history_data = [{'id': record.id, 'content': record.content} for record in history_records]

    response_data = ResponseData(code=0, msg='Success', data=history_data)
    return jsonify(response_data.__dict__)

@app.route('/content/suggestions', methods=['GET'])
def get_suggestions():
    suggestions = SuggestionModel.query.all()
    suggestions_data = [{'id': suggestion.id, 'suggestion': suggestion.suggestion} for suggestion in suggestions]

    response_data = ResponseData(code=0, msg='Success', data=suggestions_data)
    return jsonify(response_data.__dict__)

@app.route('/content/hottopics', methods=['GET'])
def get_hottopics():
    hot_topics = HotTopicModel.query.all()
    hot_topics_data = [{
        'id': topic.id,
        'rank': topic.rank,
        'title': topic.title,
        'views': topic.views,
        'isHot': topic.isHot
    } for topic in hot_topics]

    response_data = ResponseData(code=0, msg='Success', data=hot_topics_data)
    return jsonify(response_data.__dict__)

@app.route('/content/items', methods=['GET'])
def get_items():
    items = ItemModel.query.all()
    items_data = [{'id': item.id, 'item': item.item} for item in items]

    response_data = ResponseData(code=0, msg='Success', data=items_data)
    return jsonify(response_data.__dict__)

@app.route('/api/posts', methods=['GET'])
def get_posts():
    posts = PostModel.query.all()
    post_list = [{'title': post.title, 'author': post.author, 'imageUrl': post.image_url} for post in posts]
    response_data = ResponseData(code=0, msg='Success', data=post_list)
    return jsonify(response_data.__dict__)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=1337)