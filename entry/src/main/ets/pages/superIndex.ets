import { CarouselList, Like, reMen, yugao } from '../api'
import { bottomNavBar, chaoyingNavBar, likeNavBar, yugaoNavBar } from '../components/superIndex'
import { carouselListDataClass, chaoyingDataClass, chaoyingRequestClass, likeDataClass } from '../models'
import { router } from '@kit.ArkUI'
import thermal from '@ohos.thermal'

@Styles function wh100(){
  .width("100%")
  .height("100%")
}
class builderlist{
  icon:string=""
  title:string=""
}
@Entry
@Component
struct SuperIndex {
@State carouselListData:carouselListDataClass[]=[]
  @State chaoyingData:chaoyingDataClass[]=[new chaoyingDataClass(),new chaoyingDataClass(),new chaoyingDataClass(),new chaoyingDataClass()]
  @State yugaoData:chaoyingDataClass[]=[new chaoyingDataClass(),new chaoyingDataClass(),new chaoyingDataClass(),new chaoyingDataClass()]
  @State likeData:likeDataClass[]=[new likeDataClass(),new likeDataClass(),new likeDataClass(),new likeDataClass()]
  @State bg:ResourceColor="#fbfbfc"
  //刷新
  @State refreshing:boolean=false;
  @State  curRefreshStatus:RefreshStatus=RefreshStatus.Inactive;//刷新的状态；根据刷新状态显示不同文字
  @Builder list($$:builderlist){
  Row(){
    Image($$.icon)
      .width(18)
    Text($$.title)
      .margin({left:10})
      .fontSize(19)
  }
  .height(50)
  .backgroundColor(Color.White)
  .width("100%")
    .padding({left:20})
  }
async aboutToAppear(): Promise<void> {
  setInterval(async ()=>{
    //头部List
    this.carouselListData=await CarouselList()
    //热门超英
    let data:chaoyingRequestClass= {
      type:"superhero"
    }
    this.chaoyingData=await reMen(data)
    //热门预告
    let yugaodata:chaoyingRequestClass= {
      type:"trailer"
    }
    this.yugaoData=await yugao(yugaodata)
    //猜你喜欢
    let likedata=await Like()
    if (likedata){
      this.likeData=likedata
    }
    this.bg=Color.Transparent
  },1000)
}
  build() {
  Column(){
    Refresh({
      refreshing:$$this.refreshing //显示刷新
    }){
      Scroll(){
        //广告
        List(){
          ListItem(){
            Column(){
              Stack({alignContent:Alignment.Top}){
                //头部轮播图
                Swiper(){
                  ForEach(this.carouselListData,(item:carouselListDataClass)=>{
                    Row(){
                      Image(item.image)
                        .width("100%")
                    }
                    .backgroundColor(this.bg)
                    .width("100%")
                    .height(200)

                  })
                }
                .indicator(
                  new DotIndicator()
                    .selectedColor("rgba(255,255,255,0.8)")
                )
                .width("100%")
                .height(200)
                .autoPlay(true)
                //正文
                List(){
                  ListItem(){
                    Column(){
                      this.list({icon:"/images/icos/hot.png",title:"热门超英"})
                      Row(){

                      }
                      chaoyingNavBar({
                        chaoyingData:this.chaoyingData,
                        bg:this.bg
                      })
                      this.list({icon:"/images/icos/interest.png",title:"热门预告"})
                      yugaoNavBar({
                        yugaoData:this.yugaoData,
                        bg:this.bg
                      })
                      this.list({icon:"/images/icos/guess-u-like.png",title:"猜你喜欢"})
                      likeNavBar({
                        likeData:this.likeData,
                        bg:this.bg
                      })
                    }

                  }
                }
                .scrollBar(BarState.Off)
                .edgeEffect(EdgeEffect.Fade)
                .position({top:200})
                .height("calc(100% - 270vp)")

              }


              //底部
              bottomNavBar({
                curIndex:0
              })
            }
            .wh100()
          }
          .backgroundColor("#f0f0f0")

        }
        .scrollBar(BarState.Off)
        .listDirection(Axis.Vertical)
      }
      .scrollable(ScrollDirection.Vertical)
    }
    .onStateChange((state:RefreshStatus)=>{//回调函数二：接受一个state:刷新状态
      this.curRefreshStatus=state;
      if ( state==RefreshStatus.Refresh){
        this.chaoyingData=[new likeDataClass(),new likeDataClass(),new likeDataClass(),new likeDataClass()];
        this.yugaoData=[new likeDataClass(),new likeDataClass(),new likeDataClass(),new likeDataClass()];
        this.likeData=[new likeDataClass(),new likeDataClass(),new likeDataClass(),new likeDataClass()];
        this.carouselListData=[];
        this.bg="#fbfbfc"

        setTimeout(async ()=>{
          this.refreshing=false;
          //头部List
          this.carouselListData=await CarouselList()
          //热门超英
          let data:chaoyingRequestClass= {
            type:"superhero"
          }
          this.chaoyingData=await reMen(data)
          //热门预告
          let yugaodata:chaoyingRequestClass= {
            type:"trailer"
          }
          this.yugaoData=await yugao(yugaodata)
          //猜你喜欢
          let likedata=await Like()
          if (likedata){
            this.likeData=likedata
          }
          this.bg=Color.Transparent
        },1000)
      }
    })
            }


  }


}