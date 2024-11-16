import { Actor, Detail } from '../api'
import { actorNavBar, juzhaoNavBar, videoNavBar } from '../components/superIndex'
import { detailDataClass, detailRequestClass, staffDataClass, staffRequestClass } from '../models'
import { local } from './myLocalStorage'
import { router } from '@kit.ArkUI'
@Extend(Text) function globalTextStyle(){
  .fontColor(Color.Gray)
  .fontSize(14)
}
class  datail2Type{
  title:string=""
}
@Entry(local)
@Component
struct superDetail{
  @StorageLink('Zindex') Zindexx:number=0
  @State detailData:detailDataClass[]=[]
  @State actorData1:staffDataClass[]=[]
  @State selectedIndex:number = -1;
  @State actorData2:staffDataClass[]=[]
  @State actorData:staffDataClass[]=[]
  @State bg:ResourceColor="#fbfbfc"
  async aboutToAppear(): Promise<void> {
     let id=(router.getParams() as detailRequestClass).trailerId
     let data:detailRequestClass={
      trailerId:id
    }
    let actorData1:staffRequestClass={
       trailerId:id,
       role:"1"
    }
    let actorData2:staffRequestClass={
      trailerId:id,
      role:"2"
    }
    if (id){
      this.detailData = await Detail(data) as detailDataClass[]
      this.actorData1=await Actor(actorData1)
      this.actorData2=await Actor(actorData2)
      this.actorData = [...this.actorData1, ...this.actorData2];
    }
  }
  @Builder content(){
    Row(){
      Row(){
        Image(this.detailData[0]?.poster)
      }
      .backgroundColor(this.bg)
        .height(178)
        .width(130)
      Row(){
        Column({space:5}){
          Row(){
            Text(this.detailData[0]?.name)
              .fontSize(20)
              .fontWeight(500)
          }
          .backgroundColor(this.bg)
          .width(130)
          .height(23)
          Text(this.detailData[0]?.basicInfo)
            .globalTextStyle()
            .margin({top:20})
          Text("原名 : "+this.detailData[0]?.originalName).globalTextStyle()
          Text("制片时长 : "+this.detailData[0]?.totalTime)
            .globalTextStyle()
          Text("上映时间 : "+this.detailData[0]?.releaseDate)//

            .globalTextStyle()
          Row(){
            Row(){
              Text("综合评分")
                .width(50)
                .fontWeight(900)

              Rating({
                rating:Number(5/10*(Number(this.detailData[0]?.score))),
                indicator:false
              })
                .width(95)
                .stars(5)
                .stepSize(0.1)

              Text(this.detailData[0]?.score)
                .fontSize(12)
                .fontColor(Color.Gray)
            }
            .shadow({
              radius:20,
              color:Color.Gray,
              offsetX:15,
              offsetY:15
            })
            .margin({top:10})
            .padding({right:20,left:10})
            .backgroundColor(Color.White)
            .height(70)
          }
          .width(180)
          .height(70)
          .backgroundColor(this.bg)

        }
        .layoutWeight(1)
        .margin({left:10})
        .alignItems(HorizontalAlign.Start)
      }
      .backgroundColor(this.bg)
      .height(226)
      .width(180)

    }
    .width("100%")

  }
  @Builder detail2list($$:datail2Type){
    Row(){
      Text($$.title)
        .fontColor("#8d8c8c")
    }
    .width("100%")
    .padding(15)
  }
  build() {
    Stack({
      alignContent:Alignment.Top
    }){
     videoNavBar()
     List(){
        ListItem(){
          Column(){
            //图片
            Row(){
              this.content()
            }
            .padding(20)
            //横线
            Row(){}
            .width("90%")
            .height(2)
            .backgroundColor("#626262")
            .margin({bottom:20})
            //剧情介绍
            this.detail2list({title:"剧情介绍"})
            Text(this.detailData[0]?.plotDesc)
              .textIndent(2)
              .padding({left:10,right:10})
            //演职人员
            this.detail2list({title:"演职人员"})
            actorNavBar({
              actorData:this.actorData,
              selectedIndex: this.selectedIndex
            })
            //剧照
            this.detail2list({title:"剧照"})
            juzhaoNavBar({
              actorData:this.actorData,
              selectedIndex: this.selectedIndex
            })

          }

        }
        .width("100%")


      }
      .edgeEffect(EdgeEffect.Fade)
      .listDirection(Axis.Vertical)
      .zIndex(this.Zindexx)
      .width("100%")
      .scrollBar(BarState.Off)
      .height("calc(100% - 200vp)")
      .backgroundColor("#f0f0f0")
      .position({top:200})
      Column() {
        if (this.selectedIndex != -1) {
          Image(this.actorData[this.selectedIndex].photo)
            .width('100%')
        }
      }.visibility(this.selectedIndex == -1 ? Visibility.None : Visibility.Visible)
      .height('100%')
      .width('100%')
      .backgroundColor('black')
      .zIndex(999)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.selectedIndex = -1;
      })
    }
    .width("100%")
    .height("100%")
  }
}