import router from '@ohos.router';
import LoginUtil from '../utils/LoginUtil'
import UserProfilePage from './UserProfilePage'


@Entry
@Component

struct SideBarContainerTest {

  aboutToAppear() {
    LoginUtil.checkLoginStatus();
  }

  @State currentIndex: number = 0
  @State currentIndex1: number = 0
  @State fontColor: string = '#000'
  @State selectedFontColor: string = '#000'

  @Builder tabBuilder(index: number, name: string) {
    Column() {
      if(name=='关注') {
        Text(name)
          .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
          .fontSize(20)
          .fontWeight(this.currentIndex === index ? 600 : 400)
          .lineHeight(22)
          .margin({ top: 17, bottom: 7 ,left:60})
        Divider()
          .width(50)
          .margin({left:55})
          .strokeWidth(2)
          .color('#EE6363')
          .opacity(this.currentIndex === index ? 1 : 0)
      }else
        if(name=='发现') {
          Text(name)
            .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
            .fontSize(20)
            .fontWeight(this.currentIndex === index ? 600 : 400)
            .lineHeight(22)
            .margin({ top: 17, bottom: 7 ,left:0})
          Divider()
            .width(50)
            .strokeWidth(2)
            .color('#EE6363')
            .opacity(this.currentIndex === index ? 1 : 0)
        }else
        if(name=='我的') {
          Text(name)
            .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
            .fontSize(20)
            .fontWeight(this.currentIndex === index ? 600 : 400)
            .lineHeight(22)
            .margin({ top: 17, bottom: 7 ,left:-60})
          Divider()
            .width(50)
            .margin({right:98})
            .strokeWidth(2)
            .color('#EE6363')
            .opacity(this.currentIndex === index ? 1 : 0)
        }
    }.width('100%')
    .backgroundColor('#FFFAFA')
  }

  @Builder tabBuilder1(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex1 === index ? this.selectedFontColor : this.fontColor)
        .fontSize(20)
        .fontWeight(this.currentIndex1 === index ? 600 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      //.onClick(() => {
      //router.pushUrl({ url: 'pages/PageTwoTest' })
      //})
      Divider()
        .strokeWidth(2)
        .color('#EE6363')
        .opacity(this.currentIndex1 === index ? 1 : 0)
    }
    .width('100%')
    .backgroundColor('#FFFAFA')
  }

  @Builder tab() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent(){
        Column() {
          Tabs({ barPosition: BarPosition.Start }) {
            TabContent() {
              Text('关注的内容').fontSize(30).fontColor('#000')

            }
            .tabBar(this.tabBuilder(0, '关注'))

            TabContent() {
              Text('发现的内容').fontSize(30).fontColor('#000')
            }
            .tabBar(this.tabBuilder(1, '发现'))

            TabContent() {
              Text('我').fontSize(30).fontColor('#000')
            }
            .tabBar(this.tabBuilder(2, '我的'))
          }
          .animationDuration(0)
          .backgroundColor('#FFFAFA')//主页面（关注的内容）颜色
          .onChange((index: number) => {
            this.currentIndex = index
          })
        }
        .width('100%')
      }
      .tabBar(this.tabBuilder1(0, '首页'))

      // 其他TabContent内容：发现、推荐、我的

      TabContent() {
        Text('推荐的内容').fontSize(30).fontColor('#000')

      }
      .tabBar(this.tabBuilder1(1, '推荐'))

      TabContent() {
        Text('消息的内容').fontSize(30).fontColor('#000')
      }
      .tabBar(this.tabBuilder1(2, '消息'))

      TabContent() {
        UserProfilePage()
      }
      .tabBar(this.tabBuilder1(3, '我'))
    }
    .animationDuration(0)
    .backgroundColor('#FFFAFA')
    .onChange((index: number) => {
      this.currentIndex1 = index
    })
    .scrollable(false)

    Text("内容区域")
      .width("100%")
      .height("100%")
      .fontSize(30)
      .textAlign(TextAlign.Center)
  }

  build() {
    SideBarContainer(SideBarContainerType.Overlay) { // 设置侧边栏样式为悬浮态
      Column() {                                     // 第一个子组件为侧边栏视图
        Column({space: 10}) {
          Row() {
            Text('Bluetooth').fontSize(20)      // 靠左显示
            Blank()                             // 铺满剩余尺寸
            Toggle({ type: ToggleType.Switch }) // 靠右显示
          }
          .width('100%')
          .backgroundColor(Color.Gray)//上下导航栏颜色
          .borderRadius(15)
          .padding({ left: 10})
          .margin({top:50})
          Row() {
            Text('WLAN').fontSize(20)      // 靠左显示
            Blank()                             // 铺满剩余尺寸
            Toggle({ type: ToggleType.Switch }) // 靠右显示
          }
          .width('100%')
          .backgroundColor(Color.Gray)
          .borderRadius(15)
          .padding({ left: 10})
        }
        .padding(10)
        .size({ width: "100%", height: '100%' })
        Text("侧边栏区域")
          .width("100%")
          .height("100%")
          .fontSize(30)
          .textAlign(TextAlign.Center)
      }
      .width(10)
      .height("100%")
      .backgroundColor("#FCF5E5")//侧边栏颜色


      Column() { // 第二个子组件为内容区视图
        this.tab()
        Button({type: ButtonType.Circle}) {
          Image($r("app.media.ic_search_0"))
        }
        .width(30)
        .height(30)
        .backgroundColor("fff")
        .position({x:307,y:15})
        .onClick(() => {
          router.pushUrl({ url: 'pages/Search' })
        })
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#28282B")
    }
    .width('100%')
    .height('100%')
    .showSideBar(false)
    .sideBarWidth(300)                               // 设置侧边栏宽度为150
    .minSideBarWidth(100)                            // 设置侧边栏最小宽度为100
    .maxSideBarWidth(300)                            // 设置侧边栏最大宽度为200
    .controlButton({                                 // 设置侧边栏控制按钮的样式
      width: 30,                                     // 设置侧边栏控制按钮宽度为30
      height: 30,                                    // 设置侧边栏控制按钮高度为30
      top: 15,                                       // 设置侧边栏控制按钮距离容器顶部为15

      //icons: {                                       // 设置侧边栏控制按钮图片
      //shown: $r("app.media.icon_back"),            // 设置侧边栏显示时控制按钮的图标。
      //hidden: $r("app.media.icon_menu"),           // 设置侧边栏隐藏时控制按钮的图标。
      //switching: $r("app.media.icon_back")         // 设置侧边栏显示和隐藏状态切换时控制按钮的图标。
      //}
    })
  }
}