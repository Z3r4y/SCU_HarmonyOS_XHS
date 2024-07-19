import router from '@ohos.router';
import UserModel from '../model/UserModel';
import { login } from '../api/API';
import ResponseData from '../model/ResponseData';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  @State userForm: UserModel = {
    userphone: "",
    password: "",
  };

  /**
   * 执行登录
   */
  login() {
    // 要求这里有数据校验
    login(this.userForm).then(response => {
      if (response.responseCode == 200) {
        let responseData: ResponseData<UserModel> = JSON.parse(response.result as string) as ResponseData<UserModel>;
        if (responseData.code == 0) {
          // 登录成功
          const token=responseData.data?.token
          AppStorage.setOrCreate<string>("token", token); // 存储 token
          AppStorage.setOrCreate<UserModel>("user", responseData.data);
          promptAction.showToast({ message: responseData.msg });
          // 跳转界面
          router.pushUrl({ url: "pages/Index" });
        } else {
          // 登录失败
          promptAction.showToast({ message: responseData.msg });
        }
      }
    });
  }

  build() {
    Column() {
      // 顶部帮助按钮
      Row() {
        // 关闭按钮
        Text('✖')
          .fontSize(24)
          .fontColor('#000000')
          .margin({ left: 16, top: 16 })
          .onClick(() => {
            router.back();
          });

        Divider();

        // 帮助按钮
        Text('帮助')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ right: 16, top: 16 })
          .onClick(() => {
            // 帮助按钮点击事件处理
          });
      }.width('100%').justifyContent(FlexAlign.SpaceBetween);

      // 标题
      Text('密码登录')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 30, bottom: 20 })
        .textAlign(TextAlign.Center);

      // 手机号码输入框
      Row() {
        Text('+86')
          .fontSize(16)
          .margin({ right: 8 });

        TextInput({ placeholder: "请输入手机号码" })
          .type(InputType.PhoneNumber)
          .width('80%')
          .margin({ right: 8 })
          .onChange(value => this.userForm.userphone = value);

        Image($r('app.media.smile'))
          .width(20)
          .height(20)
          .onClick(() => {
            // 清除输入事件处理
          });
      }.width('90%').margin({ bottom: 10 });

      // 密码输入框
      Row() {
        TextInput({ placeholder: "输入密码" })
          .type(InputType.Password)
          .width('92.5%')
          .margin({ right: 8 })
          .onChange(value => this.userForm.password = value);

        Image($r('app.media.smile'))
          .width(20)
          .height(20)
          .onClick(() => {
            // 显示密码事件处理
          });
      }.width('90%').margin({ bottom: 10 });

      // 验证码登录和忘记密码链接
      Row() {
        Text('⇌ 验证码登录')
          .fontSize(16)
          .fontColor('#0000FF')
          .onClick(() => {
            // 验证码登录点击事件处理
          });

        Divider();

        Text('忘记密码？')
          .fontSize(16)
          .fontColor('#0000FF')
          .onClick(() => {
            // 忘记密码点击事件处理
          });
      }.width('90%').margin({ bottom: 20 });

      // 登录按钮
      Button('登录')
        .width('90%')
        .height(50)
        .backgroundColor('#FF0000') // 设置按钮底色为红色
        .fontColor('#FFFFFF')
        .fontSize(16)
        .margin({ bottom: 20 })
        .onClick((event: ClickEvent) => {
          setTimeout(() => {
            this.login();
          }, 100);
        }).width(250).fontWeight(700)
        .shadow({ radius: 10, color: "#007DFE", offsetX: 5, offsetY: 5 });

      // 用户协议复选框和文字
      Row() {
        Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
          .select(true)
          .selectedColor(0xed6f21)
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is' + value);
          })
          .padding({ right: 8 });

        Column() {
          Text('我已阅读并同意')
            .fontSize(14)
            .fontColor('#888888');

          Row() {
            Text('《用户协议》')
              .fontSize(14)
              .fontColor('#0000FF')
              .onClick(() => {
                // 用户协议点击事件
              });

            Text('《隐私政策》')
              .fontSize(14)
              .fontColor('#0000FF')
              .margin({ left: 8 })
              .onClick(() => {
                // 隐私政策点击事件
              });

            Text('《信息保护法》')
              .fontSize(14)
              .fontColor('#0000FF')
              .margin({ left: 8 })
              .onClick(() => {
                // 信息保护规则点击事件
              });
          };
        };
      }.width('90%').justifyContent(FlexAlign.Center).margin({ bottom: 20 });

      // 社交媒体登录按钮
      Row() {
        Image($r('app.media.wechat'))
          .width(40)
          .height(40)
          .margin({ left: 16, right: 16 })
          .onClick(() => {
            // 微信登录点击事件处理
          });

        Image($r('app.media.qq'))
          .width(40)
          .height(40)
          .margin({ left: 16, right: 16 })
          .onClick(() => {
            // QQ登录点击事件处理
          });

        Image($r('app.media.sina'))
          .width(40)
          .height(40)
          .margin({ left: 16, right: 16 })
          .onClick(() => {
            // 微博登录点击事件处理
          });
      }.justifyContent(FlexAlign.Center);
    }.justifyContent(FlexAlign.Center).padding({ left: 20, right: 20, top: 40, bottom: 20 });
  }
}
