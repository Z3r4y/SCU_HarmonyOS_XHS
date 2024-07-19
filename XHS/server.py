from flask import Flask, request, jsonify

app = Flask(__name__)

class ResponseData:
    def __init__(self, code=None, msg=None, data=None):
        self.code = code
        self.msg = msg
        self.data = data

class UserModel:
    def __init__(self, uid=None, username=None, password=None, userphone=None):
        self.uid = uid
        self.username = username
        self.password = password
        self.userphone = userphone

# 假设这是我们在数据库中存储的用户数据
user_db = [
    UserModel(uid=1, username='Z3r4y', password='123456', userphone='123456')
]

@app.route('/user/login', methods=['POST'])
def user_login():
    data = request.json
    phone_number = data.get('userphone')
    password = data.get('password')

    # 查找用户并验证密码
    user = next((u for u in user_db if u.userphone == phone_number and u.password == password), None)

    if user:
        response_data = ResponseData(code=0, msg='Success', data=user.__dict__)
        print("success!!!")
    else:
        response_data = ResponseData(code=1, msg='Invalid phone number or password')
        print("fail...")

    return jsonify(response_data.__dict__)

@app.route('/user/reg', methods=['POST'])
def user_register():
    data = request.json
    username = data.get('username')
    password = data.get('password')
    userphone = data.get('userphone')
    sms_code = data.get('smsCode')

    # 进行简单的校验
    if not username or not password or not userphone or not sms_code:
        response_data = ResponseData(code=400, msg='All fields are required')
        return jsonify(response_data.__dict__), 400

    # 检查手机号是否已经注册
    if any(u.userphone == userphone for u in user_db):
        response_data = ResponseData(code=409, msg='Phone number already registered')
        return jsonify(response_data.__dict__), 409

    # 假设短信验证码已经通过验证（实际应用中需要实现验证码验证逻辑）
    new_user = UserModel(uid=len(user_db) + 1, username=username, password=password, userphone=userphone)
    user_db.append(new_user)
    response_data = ResponseData(code=0, msg='Registration successful', data=new_user.__dict__)

    return jsonify(response_data.__dict__), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=1337)
