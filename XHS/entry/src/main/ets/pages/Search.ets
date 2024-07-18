import router from '@ohos.router';
import {history,suggestions,hottopics,items} from '../api/API'
import ResponseData from '../model/ResponseData'
import HistoryModel from '../model/HistoryModel'
import SuggestionModel from '../model/SuggestionModel'
import HotTopicModel from '../model/HotTopicModel'
import ItemModel from '../model/ItemModel'

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
  @State history: string[] = [];
  @State suggestions: string[] = [];
  @State hotTopics: HotTopic[] = [];
  @State items: string[] = [];

  getHistory() {
    history().then(response => {
      if (response.responseCode === 200) {
        let responseData: ResponseData<HistoryModel[]> = JSON.parse(response.result as string) as ResponseData<HistoryModel[]>;

        if (responseData.data) {
          let historyContents: string[] = [];
          // 显式类型断言
          const historyData = responseData.data as HistoryModel[];
          for (let i = 0; i < historyData.length; i++) {
            historyContents.push(historyData[i].content as string);
          }
          this.history = historyContents;
        }
      }
    });
  }

  getsuggestion() {
    suggestions().then(response => {
      if (response.responseCode === 200) {
        let responseData: ResponseData<SuggestionModel[]> = JSON.parse(response.result as string) as ResponseData<SuggestionModel[]>;

        if (responseData.data) {
          let suggestionContents: string[] = [];
          // 显式类型断言
          const suggestionData = responseData.data as SuggestionModel[];
          for (let i = 0; i < suggestionData.length; i++) {
            suggestionContents.push(suggestionData[i].suggestion as string);
          }
          this.suggestions = suggestionContents;
        }
      }
    });
  }



  getHottopic() {
    hottopics().then(response => {
      if (response.responseCode === 200) {
        let responseData: ResponseData<HotTopicModel[]> = JSON.parse(response.result as string) as ResponseData<HotTopicModel[]>;

        if (responseData.data) {
          let hottopicContents: HotTopic[] = [];
          // 显式类型断言
          const hottopicData = responseData.data as HotTopicModel[];
          for (let i = 0; i < hottopicData.length; i++) {
            hottopicContents.push(hottopicData[i] as HotTopic);
          }
          this.hotTopics = hottopicContents;
        }
      }
    });
  }

  getItem() {
    items().then(response => {
      if (response.responseCode === 200) {
        let responseData: ResponseData<ItemModel[]> = JSON.parse(response.result as string) as ResponseData<ItemModel[]>;

        if (responseData.data) {
          let itemContents: string[] = [];
          // 显式类型断言
          const itemData = responseData.data as ItemModel[];
          for (let i = 0; i < itemData.length; i++) {
            itemContents.push(itemData[i].item as string);
          }
          this.items = itemContents;
        }
      }
    });
  }

  aboutToAppear() {
    this.getHistory();
    this.getsuggestion();
    this.getHottopic();
    this.getItem();
  }

  getFilteredItems(): string[] {
    if (this.searchQuery === '') {
      return this.items;
    }
    return this.items.filter((item) => item.includes(this.searchQuery));
  }

  build() {
    Column() {
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

      if (this.searchQuery != '') {
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
      } else {
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

          Column() {
            Row() {
              Image($r('app.media.hotpoint'))
                .width(100)
            }
            .align(Alignment.Start)
            .width('100%')

            Column() {
              ForEach(this.hotTopics, (topic: HotTopic) => {
                Column() {
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
                          .padding({ right: 10 })
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
          }
          .align(Alignment.Start)
        }
        .width('%100')
        .padding({
          left: 16,
          right: 16,
          top: 10,
          bottom: 10
        })
        .backgroundColor('#FFFFFF')
      }
    }
    .padding({
      left: 16,
      right: 16,
      top: 16,
      bottom: 16
    })
    .backgroundColor('#FFFFFF')
  }}
