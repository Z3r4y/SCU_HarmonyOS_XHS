// index.ets
import router from '@ohos.router'

@Entry
@Component
struct LoginPage {
  isChecked=true
  build() {
    Column()
      {
      // 顶部帮助按钮
      Row() {
        Text('帮助')
          .fontSize(16)
          .fontColor('#888888')

        Text('✖')
          .fontSize(16)
          .fontColor('#888888')
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ right: 16})

      // 小红书logo和提示文字
      Column() {
        Text('小红书')
          .fontSize(40)
          .fontWeight('bold')
          .fontColor('#FF0000')

        Text('登录后，体验更多功能')
          .fontSize(16)
          .fontColor('#000000')
          .maxLines(1)
      }
      .justifyContent(FlexAlign.Center)
      .margin(100)
      .width(1000)

      // 微信登录按钮
      Button('微信登录（上次登录）')
        .width('90%')
        .height(50)
        .backgroundColor('#00BB00')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .onClick(() => {
          // 点击事件处理

        })
        .margin(20)

      // 手机号登录按钮
      Button('密码登录')
        .width('90%')
        .height(50)
        .backgroundColor('#D3D3D3')
        .fontColor('#000000')
        .fontSize(16)
        .onClick(() => {
          router.pushUrl({url:"pages/Login2"})
        })

      // 其他登录方式链接
      Text('其他登录方式 >')
        .fontSize(14)
        .fontColor('#0000FF')
        .padding({ top: 10 })

      // 用户协议复选框和文字
      Row() {
        Checkbox({name: 'checkbox1',  group: 'checkboxGroup'})
          .select(true)
          .selectedColor(0xed6f21)
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is'+ value)
          })
          .padding({ right: 8 })

        Column() {
          Text('我已阅读并同意')
            .fontSize(14)
            .fontColor('#888888')

          Row() {
            Text('《用户协议》')
              .fontSize(14)
              .fontColor('#0000FF')
              .onClick(() => {
                // 用户协议点击事件
              })

            Text('《隐私政策》')
              .fontSize(14)
              .fontColor('#0000FF')
              .onClick(() => {
                // 隐私政策点击事件
              })

            Text('《信息保护法》')
              .fontSize(14)
              .fontColor('#0000FF')
              .onClick(() => {
                // 信息保护规则点击事件
              })
          }
        }
      }.justifyContent(FlexAlign.Center)
        .padding({ top: 20 })
    }
    .padding({ left: 20, right: 20, top: 40, bottom: 20 })
    .justifyContent(FlexAlign.Center)
  }
}

