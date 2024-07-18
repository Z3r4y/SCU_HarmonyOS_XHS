from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import pymysql

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
    password = db.Column(db.String(80))
    userphone = db.Column(db.String(20))

    def __init__(self, username, password, userphone):
        self.username = username
        self.password = password
        self.userphone = userphone

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

@app.route('/user/login', methods=['POST'])
def user_login():
    data = request.json
    phone_number = data.get('userphone')
    password = data.get('password')

    user = UserModel.query.filter_by(userphone=phone_number, password=password).first()

    if user:
        response_data = ResponseData(code=0, msg='Success', data={
            'uid': user.uid,
            'username': user.username,
            'userphone': user.userphone
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

    new_user = UserModel(username=username, password=password, userphone=userphone)
    db.session.add(new_user)
    db.session.commit()

    response_data = ResponseData(code=0, msg='Registration successful', data={
        'uid': new_user.uid,
        'username': new_user.username,
        'userphone': new_user.userphone
    })

    return jsonify(response_data.__dict__), 200

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

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=1337)