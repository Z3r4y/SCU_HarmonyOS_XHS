import router from '@ohos.router';

class LoginUtil {
  static checkLoginStatus() {
    const token = AppStorage.get<string>("token");
    if (!token) {
      // 用户未登录，跳转到登录页面
      router.pushUrl({ url: 'pages/Login' });
    }
  }
}

export default LoginUtil;
