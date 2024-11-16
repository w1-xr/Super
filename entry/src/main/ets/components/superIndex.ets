import { bottomData } from '../constants/superIndex'
import { bottomType, chaoyingDataClass, likeDataClass,
  staffDataClass } from '../models/superIndex'
import { router } from '@kit.ArkUI'

import window from '@ohos.window';
import { mediaquery, MediaQueryEvent } from '@kit.ArkUI';
@Styles function bottom(){
  .width("100%")
  .position({bottom:0})
  .backgroundColor(Color.White)
  .height(70)
  .border({
    width:1,
    color:"#e4e4e4"
  })
}
@Component
struct bottomNavBar{
  @Prop curIndex:number
  bottomData:bottomType[]=bottomData
  build() {
   Row(){
     ForEach(this.bottomData,(item:bottomType,index:number)=>{
       Column(){
         Image(this.curIndex==index?item.selectedIcon:item.icon)
           .width(30)
         Text(item.name)
           .fontColor(this.curIndex==index?Color.Black:Color.Gray)
           .margin({top:5})
       }
       .onClick(()=>{
         router.pushUrl({
           url:item.url
         })
       })
     })
   }
    .bottom()
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)

  }
}
export {bottomNavBar}

//热门超英
@Component
struct  chaoyingNavBar{
  @Prop bg:ResourceColor="#fbfbfc"
 @Link chaoyingData:chaoyingDataClass[]
build() {
    List(){
      ForEach(this.chaoyingData,(item:chaoyingDataClass)=>{
        ListItem(){
          Column({space:10}){
            Row(){
              Image(item.poster)
                .height(150)
                .width(110)
            }
            .backgroundColor(this.bg)
            .opacity(1)
            Row(){
              Text(item.name)
                .fontSize(13)
                .maxLines(1)
                .textOverflow({
                  overflow:TextOverflow.Ellipsis
                })
            }
            .backgroundColor(this.bg)
            .width(100)
            .height(20)
            .justifyContent(FlexAlign.Start)
            Row(){
              if (this.bg==Color.Transparent){
                Rating({
                  rating:Number(5/10*(Number(item.score))),
                  indicator:false,
                })
                  .stars(5)
                  .stepSize(0.1)
                  .width(100)
                Text(item.score)
                  .fontSize(14)
                  .fontColor(Color.Gray)
              }

            }
            .width(120)
            .height(20)
            .backgroundColor(this.bg)

          }
          .onClick(()=>{
              router.pushUrl({
                url:"pages/superDetail",
                params:{
                  trailerId:item.id,
                  url:"pages/superIndex"
                }
              })
          })
          .margin({right:20,top:5})

        }
      })
    }
    .edgeEffect(EdgeEffect.Fade)
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .height(245)
    .padding({top:15,left:20,right:20})
}
}
export {chaoyingNavBar}

//热门预告
@Component
struct  yugaoNavBar{
  @Prop bg:ResourceColor="#fbfbfc"
  @Prop yugaoData:chaoyingDataClass[]=[]
  build() {
   Grid(){
     ForEach(this.yugaoData,(item:chaoyingDataClass)=>{
       GridItem(){
         Stack(){
           Row(){
             Image(item.cover)
               .height(110)
               .width(165)
           }
           .height(110)
           .width(165)
           .backgroundColor(this.bg)

           Column(){
               Image("/images/icos/play.png")
                 .width(25)
               Text(item.totalTime)
                 .fontColor(Color.White)
                 .margin({top:20})
                 .fontSize(15)
           }
           .justifyContent(FlexAlign.Center)
           .alignItems(HorizontalAlign.Center)
           .height(110)
           .width(165)
         }
       }
       .onClick(()=>{
         router.pushUrl({
           url:"pages/superDetail",
           params:{
             trailerId:item.id,
             url:"pages/superIndex"
           }
         })
       })
     })
   }
   .padding({left:10,right:10})
   .height(250)
   .margin({top:10})
   .columnsTemplate("1fr 1fr")
    .columnsGap(8)
    .rowsGap(10)

  }
}
export {yugaoNavBar}

//猜你喜欢
@Component
struct  likeNavBar{
  @Prop bg:ResourceColor="#fbfbfc"
  @Prop likeData:likeDataClass[]=[]
  @State curIndex:number=-1
  @State ani:AnimateParam={
    duration:400,
    curve:Curve.Linear,
}
  build() {
   Column(){
     ForEach(this.likeData,(item:likeDataClass,index:number)=>{
       Row(){
         Row(){
             Image(item.cover)
               .width(100)
               .height(150)
           Column({space:10}){
             Row(){
               Text(item.name)
             }
             .backgroundColor(this.bg)
             Row(){
               Rating({
                 rating:Number(5/10*(Number(item.score))),
                 indicator:false
               })
                 .stars(5)
                 .stepSize(0.1)
                 .width(100)
               Text(item.score)
                 .fontSize(12)
                 .fontColor(Color.Gray)
             }
             Text(item.basicInfo)
               .fontColor(Color.Gray)
               .fontSize(14)
             Text(item.releaseDate)
               .fontColor(Color.Gray)
               .fontSize(14)
           }
           .margin({left:10})
           .layoutWeight(1)
           .alignItems(HorizontalAlign.Start)
         }
         .width("100%")
         .height(150)
         .backgroundColor(this.bg)
         .layoutWeight(1)
         .onClick(()=>{
           router.pushUrl({
             url:"pages/superDetail",
             params:{
               trailerId:item.id,
               url:"pages/superIndex"
             }
           })
         })

         Row(){}
         .width(2)
         .height(100)
         .backgroundColor("#cfcfcf")
         .margin({left:20})
         Column(){
           Stack({alignContent:Alignment.Top}){
             Image("/images/icos/praise.png")
               .width(25)
             Image("/images/icos/praise.png")
               .width(25)
               .onClick(()=>{
                 animateTo(this.ani,()=>{
                   this.curIndex=index
                   setTimeout(()=>{
                     this.curIndex=-1
                   })

                 })



               })
               .transition({
                 type:TransitionType.Delete,
                 translate:{
                   y:-25
                 },
                 scale:{
                   x:0.7,
                   y:0.7
                 }
               })
               .visibility(this.curIndex==index ? Visibility.Hidden : Visibility.Visible)
             Text("赞一下")
               .fontColor("#feab2a")
               .fontSize(14)
               .position({top:30})
           }
         }

         .margin({left:10})
       }
       .width("100%")
       .justifyContent(FlexAlign.Start)
       .margin({bottom:15})

     })
   }
   .padding({top:15,bottom:15,left:10,right:10})
  }
}
export {likeNavBar}

//详情-视频
enum PlayState{
  play,
  paused
}
enum VideoScreenState{
  full,//全屏
  exitFull//退出全屏
}
class urlClass{
  url:string=""
}
@Component
struct videoNavBar {
  @State url:string=""
  @State flag:boolean=false
  @State img:string="/images/icos/zt.png"
  @State img2:string="/images/icos/bf.png"
  @State videoHeight: number | string = 200
  private videoController: VideoController = new VideoController();
  @State playState: PlayState = PlayState.paused;
  @State videoScreenState: VideoScreenState = VideoScreenState.exitFull
  listener = mediaquery.matchMediaSync('(orientation: landscape)') //监听横屏事件
  @State curTime: number = 0;
  @State duration: number = 0
  @State palyTime: string = ""
  @StorageLink('Zindex') Zindexx:number=0
  //设置横屏或竖屏；
  setOrientation(orientation: number) {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setPreferredOrientation(orientation)
    })
  }

  aboutToAppear(): void {
    let url=router.getParams() as urlClass
    this.url=url.url
    console.log((this.url))
    console.log(this.videoHeight+"")
    this.listenScreenDirection()
  }

  //监听屏幕旋转
  listenScreenDirection() {
    this.listener.on('change', (mediaQueryResult: MediaQueryEvent) => {
      if (mediaQueryResult.matches) {
        //横屏
        this.videoHeight = "100%"
        this.videoScreenState = VideoScreenState.full
      } else {
        //竖屏；
        this.videoHeight = 200;
        this.videoScreenState = VideoScreenState.exitFull
      }
    })

  }

  changeFullScreen() {
    if (this.videoScreenState == VideoScreenState.exitFull) {
      //全屏
      //this.videoController.requestFullscreen(true)
      //横屏
      this.setOrientation(2);
      this.videoHeight = "100%"
      this.videoScreenState = VideoScreenState.full
    } else {
      //退出全屏
      //this.videoController.exitFullscreen()

      //竖屏
      this.setOrientation(1);
      this.videoHeight = 200;
      this.videoScreenState = VideoScreenState.exitFull
    }
  }

  build() {
    Stack({
      alignContent: Alignment.Bottom
    }) {
      //返回
      Image("/images/icos/tmback.png")
        .margin({top:10})
        .width(30)
        .zIndex(77)
        .position({top:0})
        .onClick(()=>{
          router.pushUrl({
            url:this.url
          })
        })
      //1.
      Video({
        src: "/images/c.mp4",
        //previewUri:"/images/waterImg/2.jpg",
        //currentProgressRate:PlaybackSpeed.Speed_Forward_2_00_X
        controller: this.videoController
      })
        .width("100%")
        .height(this.videoHeight)
        .controls(false)//双击
        .gesture(
          TapGesture({ count: 2 })
            .onAction(() => {
              this.changeFullScreen()
              this.Zindexx=this.Zindexx==10?10:2
            })
        )
        .onPrepared((even) => {
          this.duration = even.duration;
        })
        .onUpdate(event => {
          this.curTime = event.time;
          let newTime = this.duration - this.curTime
          let s = Math.floor(newTime % 60)
          let m = Math.floor(newTime / 60 % 60);
          let h = Math.floor(newTime / 60 / 60);
          this.palyTime = `${h}:${m}:${s}`
        })
      //2.自定义播放控件；
      Row() {
        //播放或暂停；
        Image(this.flag==false?this.img:this.img2)
          .width(30)
          .onClick(() => {
           this.flag=!this.flag
            if (this.playState == PlayState.paused) {
              this.videoController.start();
              this.playState = PlayState.play
            } else {
              this.videoController.pause();
              this.playState = PlayState.paused
            }
          })

        //进度条
        Slider({
          value: this.curTime,
          max: this.duration
        })
          .width("60%")
          .margin({left:10,right:20})
          .onChange((value: number) => {
            this.videoController.setCurrentTime(value)
          })
        //全屏/退出全屏
        Image("/images/icos/screen.png")
          .width(25)
          .onClick(() => {
            this.changeFullScreen()
            this.Zindexx=this.Zindexx==10?10:2
          })

        Text(this.palyTime)
          .fontColor(Color.White)
          .margin({left:10})

      }
      .width("100%")
      .padding({left:15,right:15})
      .justifyContent(FlexAlign.Start)

    }
    .zIndex(3)
    .position({top:0})
    .height(this.videoHeight)
  }
}
export {videoNavBar}

//详情2
@Component
struct actorNavBar{
 @Prop actorData:staffDataClass[]=[]
  @Link selectedIndex: number;
  @State hei:number=140
  build() {
   List(){
     ForEach(this.actorData,(item:staffDataClass,index:number)=>{
       ListItem(){
         Column(){
           Image(item.photo)
             .height(this.hei)
           Column(){
             Text(item.actName)
               .fontSize(13)
               .fontWeight(500)
             Text(item.name)
               .fontWeight(500)
               .fontSize(13)
           }
           .margin({top:8})
           .alignItems(HorizontalAlign.Start)
         }
         .alignItems(HorizontalAlign.Start)
         .margin({right:15})
         .onClick(()=>{
           console.log(index+"")
           console.log(this.actorData[index].photo)
           this.selectedIndex = index;
         })

       }


     })
   }
   .scrollBar(BarState.Off)
   .listDirection(Axis.Horizontal)
   .padding({left:20,right:20})
  }

}
export {actorNavBar}

//详情2
@Component
struct juzhaoNavBar{
  @Prop actorData:staffDataClass[]=[]
  @Link selectedIndex: number;
  @State hei:number=140
  build() {
    List(){
      ForEach(this.actorData,(item:staffDataClass,index:number)=>{
        ListItem(){
          Column(){
            Image(item.photo)
              .height(this.hei)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({right:15})
          .onClick(()=>{
            console.log(index+"")
            console.log(this.actorData[index].photo)
            this.selectedIndex = index;
          })
        }
      })
    }
    .scrollBar(BarState.Off)
    .listDirection(Axis.Horizontal)
    .padding({left:20,right:20})
  }

}
export {juzhaoNavBar}