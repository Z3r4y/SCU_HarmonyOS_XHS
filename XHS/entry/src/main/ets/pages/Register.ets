import { reg } from '../api/API';
import { captcha } from '../api/API';
import { CaptchaModel } from '../model/CaptchaModel';
import {RegisterResponseData} from '../model/RegisterResponseData'
import ResponseData from '../model/ResponseData';
import UserModel from '../model/UserModel';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

@Entry
@Component
struct RegisterPage {
  @State sendSMSText: string = '发送验证码';
  @State selectOptions: SelectOption[] = [];
  @State captchaImageUrl: string = '';
  @State captchaText: string = '';
  @State userInput: string = '';

  // 我需要提交的数据
  @State userForm: UserModel = {
    username: "",
    password: "",
    userphone: "",
    smsCode: "",
  };
  @State index: number = 0; // 当前选中的下拉框的索引值
  intervalId: number = 0;
  @State isSendIng: boolean = false;

  async fetchCaptcha() {
    try {
      const response = await captcha();
      console.log('Response:', response);
      if (response.responseCode === 200) {
        let data: CaptchaModel;

        // 检查 response.result 是否已经是 JSON 对象
        if (typeof response.result === 'string') {
          data = JSON.parse(response.result) as CaptchaModel;
        } else {
          data = response.result as CaptchaModel;
        }

        this.captchaText = data.captcha_text;
        console.log('this.captchaText:', this.captchaText);

        this.captchaImageUrl = `data:image/png;base64,${data.captcha_image}`;
        console.log('this.captchaImageUrl:', this.captchaImageUrl);
      } else {
        console.error('Failed to fetch captcha');
      }
    } catch (error) {
      console.error('Error fetching captcha:', error);
    }
  }

  validateCaptcha() {
    if (this.userInput === this.captchaText) {
      console.log('Captcha validated successfully');
      return true;
    } else {
      console.error('Invalid captcha');
      promptAction.showToast({ message: '验证码错误' });
      return false;
    }
  }

  sendSMS() {
    // 发送短信倒计时60秒
    let index = 60;
    // 循环执行的定时器
    this.intervalId = setInterval(() => {
      if (index == 0) {
        this.sendSMSText = '发送验证码';
        this.isSendIng = false;
        clearInterval(this.intervalId);
      } else {
        this.sendSMSText = `${index}秒后重试`;
        index--;
      }
    }, 1000);
  }

  /**
   * 执行注册
   */
  reg() {
    //需要先校验数据
    if (this.userForm.username == "") {
      promptAction.showToast({
        message: "请输入你的姓名"
      });
      return;
    }
    if (this.userForm.password == "") {
      promptAction.showToast({
        message: "请输入你的密码"
      });
      return;
    }
    if (this.userForm.userphone == "") {
      promptAction.showToast({
        message: "请输入你的手机号"
      });
      return;
    }
    if (this.userForm.smsCode == "") {
      promptAction.showToast({
        message: "请输入短信验证码"
      });
      return;
    }
    if (!this.validateCaptcha()) {
      return;
    }

    reg(this.userForm).then(response => {
      if (response.responseCode === 200) {
        let result = JSON.parse(response.result as string) as ResponseData<RegisterResponseData>;
        if (result.code === 0 && result.data) {
          // 注册成功
          promptAction.showToast({
            message: "注册成功"
          });
          // 存储 token
          const token: string = result.data.token;
          AppStorage.setOrCreate<string>("token", token);
          // 跳转到主页
          router.pushUrl({ url: "pages/Index" });
        } else {
          promptAction.showToast({
            message: result.msg
          });
        }
      } else {
        promptAction.showToast({
          message: '注册失败，请稍后再试'
        });
      }
    });

  }

  build() {
    Column() {
      Column() {
        Row() {
          Text("小红书").fontSize(25).fontWeight(700).fontColor('#FF0000').margin({ right: 10 }).border({
            width: 1,
            style: BorderStyle.Solid,
            color: Color.Red,
          });
          Text("用户注册").fontSize(25).fontWeight(700);
          Image($r('app.media.xhs')).width(40).margin({ left: 80 });
        }.width('100%')
        .margin({ top: 50 });
        Column() {
          Row() {
            Text("姓名").fontWeight(700).margin({ left: 8 }).fontSize(20);
          }.width('100%').justifyContent(FlexAlign.Start);
          Row() {
            TextInput({ placeholder: "请输入你的姓名", text: this.userForm.username })
              .backgroundColor(Color.White)
              .onChange(value => this.userForm.username = value);
          };
        }.margin({ top: 20 }).border({ width: { bottom: 1 }, color: "#F4F6F7" });
        Column() {
          Row() {
            Text("手机号").fontWeight(700).margin({ left: 8 }).fontSize(20);
          }.width('100%').justifyContent(FlexAlign.Start);
          Row() {
            TextInput({ placeholder: "请输入你的手机号", text: this.userForm.userphone })
              .backgroundColor(Color.White)
              .onChange(value => this.userForm.userphone = value);
          };
        }.margin({ top: 20 }).border({ width: { bottom: 1 }, color: "#F4F6F7" });
        Column() {
          Row() {
            Text("图片验证码").fontWeight(700).margin({ left: 8 }).fontSize(20);
          }.width('100%').justifyContent(FlexAlign.Start);
          Row() {
            TextInput({ placeholder: "请输入图片验证码", text: this.userInput })
              .backgroundColor(Color.White)
              .layoutWeight(1)
              .onChange(value => this.userInput = value);
            Button('刷新')
              .backgroundColor(Color.Brown)
              .onClick((): Promise<void> => this.fetchCaptcha());
            if (this.captchaImageUrl) {
              Image(this.captchaImageUrl)
                .width(100)
                .height(40);
            }
          };
        }.margin({ top: 20 }).border({ width: { bottom: 1 }, color: "#F4F6F7" });
        Column() {
          Row() {
            Text("短信验证码").fontWeight(700).margin({ left: 8 }).fontSize(20);
          }.width('100%').justifyContent(FlexAlign.Start);
          Row() {
            TextInput({ placeholder: "请输入短信验证码", text: this.userForm.smsCode })
              .backgroundColor(Color.White)
              .layoutWeight(1)
              .onChange(value => this.userForm.smsCode = value);
            Text(this.sendSMSText).fontColor("#95CAFF").onClick(() => {
              if (!this.isSendIng) {
                this.isSendIng = true;
                this.sendSMS();
              }
            });
          };
        }.margin({ top: 20 }).border({ width: { bottom: 1 }, color: "#F4F6F7" });
        Column() {
          Row() {
            Text("密码").fontWeight(700).margin({ left: 8 }).fontSize(20);
          }.width('100%').justifyContent(FlexAlign.Start);
          Row() {
            TextInput({ placeholder: "请输入你的密码", text: this.userForm.password })
              .type(InputType.Password)
              .showPasswordIcon(true)
              .backgroundColor(Color.White)
              .onChange(value => this.userForm.password = value);
          };
        }.margin({ top: 20 }).border({ width: { bottom: 1 }, color: "#F4F6F7" });
        Column() {
          Button("注册")
            .backgroundColor(Color.Red)
            .onClick((event: ClickEvent) => {
              setTimeout(() => {
                this.reg();
              }, 100);
            })
            .width('100%')
            .shadow({ radius: 10, color: "#007DFE", offsetX: 5, offsetY: 5 })
            .backgroundColor('#FF0000');
          Text("账号登录").margin({ top: 20 }).fontColor('#8E8E8E')
            .onClick(() => {
              router.pushUrl({ url: "pages/Login" });
            });
        }.margin({ top: 20 });
        Image($r('app.media.xhs2'))
          .padding({ top: 20 })
          .width(180);
      }.width('90%')
      .height('100%');
    }
    .height('100%')
    .width('100%');
  }
}
