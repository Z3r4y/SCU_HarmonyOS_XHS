import LoginUtil from '../utils/LoginUtil'
import {profile} from '../api/API'
import UserModel from '../model/UserModel'
import ResponseData from '../model/ResponseData'

@Entry
@Component
struct UserProfilePage {
  @State userName: string = '';
  @State userNumber: string = '';
  @State description: string = '';
  @State following: number = 0;
  @State followers: number = 0;
  @State likes: number = 0;

  aboutToAppear() {
    LoginUtil.checkLoginStatus();
    this.fetchUserData();
  }

  async fetchUserData() {
    try {
        const token = AppStorage.get<string>("token");
        if (!token) {
          console.error('Token is missing');
          return;
        }
      const response = await profile(token);
      if (response.responseCode == 200) {
        const responseData: ResponseData<UserModel> = JSON.parse(response.result as string);
        if (responseData.code == 0 && responseData.data !== undefined) {
          // 登录成功并且 data 不为 undefined
          const userData = responseData.data;
          this.userName = userData.username || '';
          this.userNumber = userData.user_number || '';
          this.description = userData.description || '';
          this.following = userData.following || 0;
          this.followers = userData.followers || 0;
          this.likes = userData.likes || 0;
        } else {
          console.error('User data is undefined or code is not 0');
        }
      } else {
        console.error('Failed to fetch user data:', response.responseCode);
      }
    } catch (error) {
      console.error('Error fetching user data:', error);
    }
  }

  build() {
    Column() {
      // Top section with background and profile info
      ProfileSection({
        userName: this.userName,
        userNumber: this.userNumber,
        description: this.description,
        following: this.following,
        followers: this.followers,
        likes: this.likes
      })
      // Menu
      MenuSection()
      // Tab
      TabSection()
      // Notes
      NotesSection()
      // Share section
      ShareSection()
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct ProfileSection {
  @Prop userName: string;
  @Prop userNumber: string;
  @Prop description: string;
  @Prop following: number;
  @Prop followers: number;
  @Prop likes: number;

  build() {
    Column() {
      Stack() {
        Column() {
          Row() {
            Image($r('app.media.profile_background')) // 背景图片
              .width('100%')
              .height(200)
          }
          // Profile details
          Column() {
            Row() {
              Image($r('app.media.profile_img')) // 用户头像
                .width(70)
                .height(70)
                .borderRadius(35)
                .border({ width: 2, color: Color.Gray }) // 添加实线边框
                .margin({ right: 10 })
              Column() {
                Text(this.userName)
                  .fontSize(18)
                  .fontWeight(700)
                  .margin({ bottom: 4 })
                Text(`小红书号: ${this.userNumber}`)
                  .fontSize(14)
                  .fontColor('#999')
              }
            }
            Row() {
              Text(this.description)
                .fontSize(14)
                .fontColor('#666')
                .margin({ top: 10 })
            }
            Row() {
              Text(`${this.following} 关注`)
                .fontSize(14)
                .fontWeight(700)
                .margin({ right: 20 })
              Text(`${this.followers} 粉丝`)
                .fontSize(14)
                .fontWeight(700)
                .margin({ right: 20 })
              Text(`${this.likes} 获赞与收藏`)
                .fontSize(14)
                .fontWeight(700)
            }
            Row() {
              Button('编辑资料')
                .fontSize(14)
                .padding({ left: 10, right: 10 })
                .margin({ top: 10, right: 10 })
              Button('设置')
                .fontSize(14)
                .padding({ left: 10, right: 10 })
                .margin({ top: 10 })
            }
          }
        }
      }
    }
  }
}

@Component
struct MenuSection {
  build() {
    Row() {
      Text('购物车')
        .fontSize(14)
        .fontColor('#666')
        .width('33%')
        .padding({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
      Text('创作灵感')
        .fontSize(14)
        .fontColor('#666')
        .width('33%')
        .padding({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
      Text('浏览记录')
        .fontSize(14)
        .fontColor('#666')
        .width('33%')
        .padding({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
    }
  }
}

@Component
struct TabSection {
  build() {
    Row() {
      Column() {
        Text('笔记')
          .fontSize(16)
          .fontWeight(700)
          .fontColor('#FF4D4F')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 10, bottom: 10 })
        Divider()
          .color(Color.Red)
          .strokeWidth(2)
          .width('100%')
      }
      .width('33%')
      Column() {
        Text('收藏')
          .fontSize(16)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 10, bottom: 10 })
      }
      .width('33%')
      Column() {
        Text('赞过')
          .fontSize(16)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 10, bottom: 10 })
      }
      .width('33%')
    }
  }
}

@Component
struct NotesSection {
  build() {
    Row() {
      Text('公开 · 0')
        .fontSize(14)
        .fontColor('#999')
        .padding({ top: 10, bottom: 10, right: 10 })
      Text('私密 · 0')
        .fontSize(14)
        .fontColor('#999')
        .padding({ top: 10, bottom: 10, right: 10 })
      Text('合集 · 0')
        .fontSize(14)
        .fontColor('#999')
        .padding({ top: 10, bottom: 10, right: 10 })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
  }
}

@Component
struct ShareSection {
  build() {
    Column() {
      Text('分享你们的恋爱秘籍')
        .fontSize(14)
        .fontColor('#666')
        .padding({ top: 10, bottom: 10 })
      Button('去分享')
        .fontSize(14)
        .padding({ left: 10, right: 10 })
        .margin({ top: 10 })
    }
  }
}

export default UserProfilePage;
