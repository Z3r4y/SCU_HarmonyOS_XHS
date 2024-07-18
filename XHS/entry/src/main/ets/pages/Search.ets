import router from '@ohos.router';
import { StartOptions } from '@kit.AbilityKit';

// 定义接口描述热点数据的结构
interface HotTopic {
  rank: number;
  title: string;
  views: string;
  isHot?: boolean;
}

@Entry
@Component
struct SearchPage {
  @State searchQuery: string = '';
  @State history: string[] = ['川大', '川大网安','Z3r4y','恋爱'];
  @State suggestions: string[] =
    ['川大军训', '卡地亚TRINITY', '川大录取通知书', '情侣升温情话', '情侣见面小花束', '茉莉花的花语'];
  @State hotTopics: HotTopic[] = [
    { rank: 1, title: '27岁硕导迎来26岁开门弟子', views: '1100.0w' ,isHot: true},
    { rank: 2, title: '她自律得不像是大学生', views: '856.4w' },
    {
      rank: 3,
      title: '现实版海绵宝宝上班',
      views: '803.3w',
      isHot: true
    },
    { rank: 4, title: '蓝盈莹的精神内核好强大', views: '774.6w' },
    { rank: 5, title: '狗皮膏药还得狗狗来撕', views: '769.4w' },
    { rank: 6, title: '成熟的打戏已经进化到绿幕直出了', views: '652.3w' },
    {
      rank: 7,
      title: '长相思的特效有点太抽象了',
      views: '621.7w',
      isHot: true
    },
    {
      rank: 8,
      title: '最近流行去吐鲁番法湿气',
      views: '557.5w',
      isHot: true
    },
    {
      rank: 9,
      title: '电影抓娃娃真人版点读机上线',
      views: '555.1w',
    },
  ];
  @State items: string[] = ['川大军训', '卡地亚TRINITY', '川大录取通知书', '情侣升温情话', '情侣见面小花束', '茉莉花的花语','川大网安'];

  getFilteredItems(): string[] {
    if (this.searchQuery === '') {
      return this.items;
    }
    return this.items.filter((item) => item.includes(this.searchQuery));
  }


  build() {
    Column() {
      // 搜索栏
      Row() {
        Image($r("app.media.search_icon"))
          .width(20)
          .height(20)
          .margin({ left: 16 })

        TextInput({ placeholder: '川大军训' })
          .onChange((value: string) => {
            this.searchQuery = value;
          })
          .width('70%')
          .margin({ left: 10 })

        Text('搜索')
          .fontSize(16)
          .margin({ left: 10, right: 16 })
          .onClick(() => {
            router.pushUrl({url:'pages/Index'})
          })
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#F2F2F2')

      //搜索栏
      if(this.searchQuery!=''){
        List() {
          ForEach(this.getFilteredItems(), (item: string, index: number) => {
            ListItem() {
              Column() {
                Text(item)
                  .fontSize(16)
                  .padding({ top: 10, bottom: 10 })
                  .textAlign(TextAlign.Start)
                  .width('%100')
                  .align(Alignment.Start)

                // 添加分割线
                if (index < this.getFilteredItems().length - 1) {
                  Divider().color('#E0E0E0').width('100%').height(1)
                }
              }
              .justifyContent(FlexAlign.Start)
              .width('%100')
              .alignItems(HorizontalAlign.Start)
            }
          })
        }
        .width('100%')
      }
      //正常显示
      else{
        Column() {
        Text('历史记录')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16, top: 10, bottom: 10 })
          .width('100%')

        Row() {
          ForEach(this.history, (item: string) => {
            Text(item)
              .fontSize(14)
              .padding({
                left: 10,
                right: 10,
                top: 5,
                bottom: 5
              })
              .backgroundColor('#E0E0E0')
              .borderRadius(15)
              .margin({ left: 16, bottom: 10 })
          })
        }
      }
      .padding({
        left: 16,
        right: 16,
        top: 10,
        bottom: 10
      })
      .backgroundColor('#FFFFFF')

        Column() {
          Text('猜你想搜')
            .fontSize(16)
            .fontWeight(700)
            .margin({ left: 16, top: 10, bottom: 10 })
            .align(Alignment.Start)
            .width('100%')

          Column() {
            ForEach(this.suggestions, (item: string, index: number) => {
              if (index % 2 === 0) {
                Row({ space: 10 }) {
                  Text(item)
                    .fontSize(14)
                    .padding({
                      left: 10,
                      right: 10,
                      top: 5,
                      bottom: 5
                    })
                    .margin({ left: 16, bottom: 10 })
                    .backgroundColor('#F2F2F2')
                    .borderRadius(5)
                    .textAlign(TextAlign.Start)

                  if (index + 1 < this.suggestions.length) {
                    Text(this.suggestions[index + 1])
                      .fontSize(14)
                      .padding({
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 5
                      })
                      .margin({ left: 16, bottom: 10 })
                      .backgroundColor('#F2F2F2')
                      .borderRadius(5)
                      .textAlign(TextAlign.Start)
                  }
                }
              }
            })
          }

          // 热点
          Column() {
            Row(){
              Image($r('app.media.hotpoint'))
                .width(100)
            }.align(Alignment.Start)
            .width('100%')


            Column() { // 将所有子项左对齐
              ForEach(this.hotTopics, (topic: HotTopic) => {
                Column() { // 使用Column包裹Row和Divider
                  Row() {
                    Text(topic.rank.toString())
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .margin({ left: 16 })

                    Row() {
                      Text(topic.title)
                        .fontSize(14)
                        .fontWeight(FontWeight.Bold)
                        .margin({ left: 10, right: 10 })

                      if (topic.isHot) {
                        Image($r('app.media.fire'))
                          .width(25)
                          .padding({right:10})
                      }
                    }

                    Text(topic.views)
                      .fontSize(14)
                      .fontColor('#AAAAAA')
                      .margin({ left: 'auto', right: 16 })
                  }
                  .padding({ top: 10, bottom: 10 })
                  .backgroundColor('#FFFFFF')
                  .width('100%')

                  // 分割线
                  Divider()
                    .color(Color.Gray)
                    .strokeWidth(1)
                    .width('100%')
                }
              })
            }
            .width(350)
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .backgroundColor('#FFFFFF')
            .justifyContent(FlexAlign.Start)
            .align(Alignment.Start)
          }.align(Alignment.Start)
        }
        .width('%100')
        .padding({
          left: 16,
          right: 16,
          top: 10,
          bottom: 10
        })
        .backgroundColor('#FFFFFF')} // 历史记录

      }
      .padding({
        left: 16,
        right: 16,
        top: 16,
        bottom: 16
      })
      .backgroundColor('#FFFFFF')
    }
  }
