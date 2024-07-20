import FriendModel from '../model/FriendModel';
import { friends } from '../api/API';
import ResponseData from '../model/ResponseData';

@Entry
@Component
struct MessagePage {
  @State friendList: FriendModel[] = [];

  aboutToAppear() {
    this.loadFriends();
  }

  async loadFriends() {
    try {
      const response = await friends();
      if (response.responseCode === 200) {
        const responseData: ResponseData<FriendModel[]> = JSON.parse(response.result as string) as ResponseData<FriendModel[]>;
        if (responseData.code === 0 && responseData.data !== undefined) {
          this.friendList = responseData.data;
        }
      }
    } catch (error) {
      console.error('Error fetching friends:', error);
    }
  }

  build() {
    Scroll() {
      Column() {
        // 顶部导航栏
        Row() {
          Text('消息')
            .fontSize(18)
            .fontWeight('bold')
            .align(Alignment.Center);
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ top: 20, bottom: 30 });

        // 消息选项
        Row() {
          Column() {
            Image($r('app.media.like'))
              .width(50)
              .height(50);
            Text('赞和收藏')
              .fontSize(14);
          }.alignItems(HorizontalAlign.Center)
          .margin(20);
          Column() {
            Image($r('app.media.new_follower'))
              .width(50)
              .height(50);
            Text('新增关注')
              .fontSize(14);
          }.alignItems(HorizontalAlign.Center)
          .margin(20);
          Column() {
            Image($r('app.media.comment'))
              .width(50)
              .height(50);
            Text('评论和@')
              .fontSize(14);
          }.alignItems(HorizontalAlign.Center)
          .margin(20);
        }.justifyContent(FlexAlign.SpaceAround)
        .padding(10);

        // 活动消息
        Row() {
          Image($r('app.media.activity'))
            .width(40)
            .height(40);
          Column() {
            Text('活动消息')
              .fontSize(16)
              .fontWeight('bold')
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 5 });
            Text('100%中奖，看好视频拿周边')
              .fontSize(12)
              .fontColor('#999')
              .alignSelf(ItemAlign.Start);
          }
          .padding({ left: 10 })
          .justifyContent(FlexAlign.Start)
          .width('100%');
        }.alignItems(VerticalAlign.Center)
        .padding(10)
        .justifyContent(FlexAlign.Start)
        .margin({ left: 20 });  // Ensure this margin matches the margin of "发现更多好友"

        // 分割线
        Divider();

        // 发现更多好友
        Row() {
          Text('发现更多好友')
            .fontSize(14)
            .fontWeight('bold')
            .alignSelf(ItemAlign.Start);
          Text('关闭')
            .fontSize(14)
            .fontColor('#999')
            .alignSelf(ItemAlign.End);
        }.justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 30, right: 30 })
        .width('100%')
        .margin(20);  // Ensure this margin matches the left margin of activity section

        // 好友列表
        ForEach(this.friendList, (friend: FriendModel, index) => {
          Row() {
            Image(friend.image)
              .width(40)
              .height(40)
              .borderRadius(20)
              .margin({ left: 20 });
            Column() {
              Text(friend.name)
                .fontSize(14)
                .fontWeight('bold')
                .alignSelf(ItemAlign.Start);
              Text(friend.description)
                .fontSize(12)
                .fontColor('#999')
                .alignSelf(ItemAlign.Start);
            }.padding({ left: 10 })
            .width('65%');  // Adjust width as needed to give space for buttons
            Row() {
              Button('关注')
                .fontSize(14)
                .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                .backgroundColor('#FF4D4F') // 设置背景颜色
                .fontColor('#FFFFFF'); // 设置字体颜色
            }.justifyContent(FlexAlign.End);
          }.alignItems(VerticalAlign.Center)
          .padding(10)
          .width('100%');
        });
      }
    }
  }
}

export default MessagePage