import { around } from '../api/API';
import AroundModel from '../model/AroundModel';
import ResponseData from '../model/ResponseData'

@Component
struct AroundListPage {
  @State posts: AroundModel[] = [];

  aboutToAppear() {
    this.loadPosts();
  }

  async loadPosts() {
    const response = await around();
    if (response.responseCode == 200) {
      const responseData: ResponseData<AroundModel[]> = JSON.parse(response.result as string);
      if (responseData.code == 0 && responseData.data !== undefined) {
        this.posts = responseData.data;
      }
    }
  }

  build() {
    Scroll() {
      Column({ space: 10 }) {
        ForEach(this.posts, (item:AroundModel, index) => {
          PostItem({
            title: item.title,
            author: item.author,
            imageUrl: item.imageUrl
          })
        })
      }
      .padding(10)
    }.edgeEffect(EdgeEffect.Spring)
  }
}

@Component
struct PostItem {
  @Prop title: string;
  @Prop author: string;
  @Prop imageUrl: string;

  build() {
    Column() {
      Row() {
        Image(this.imageUrl)
          .width(100)
          .height(100)
          .objectFit(ImageFit.Cover)
          .margin({ right: 10 })
        Column() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(700)
            .maxLines(2)
            .width('100%')
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .padding({right:140})
          Text(`作者: ${this.author}`)
            .fontSize(14)
            .fontColor('#999')
            .align(Alignment.Start)
            .width('100%')
        }
      }
      .width('100%')
      .padding({ bottom: 10 })
      Divider()
    }
  }
}
export default AroundListPage;