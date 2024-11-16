import { Search } from '../api/superSearch'
import { bottomNavBar } from '../components/superIndex'
import { SearchNavBar } from '../components/superSearch'
import { searchRequestClass } from '../models'
import { searchDataClass } from '../models'
import { router } from '@kit.ArkUI'

@Styles function wh100(){
  .width("100%")
  .height("100%")
}
class trailerIdClass{
  trailerId:number=-1
}
@Entry
@Component
struct SuperSearch {
  @State searchData:searchDataClass[]=[new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),]
  @State data:searchRequestClass={
    keywords:'',
    page:1,
    pageSize:10
  }
  @State bg:ResourceColor="#fbfbfc"
  //刷新
  @State refreshing:boolean=false;
  @State  curRefreshStatus:RefreshStatus=RefreshStatus.Inactive;
  async getInfo() {
    this.searchData = await Search(this.data);
  }

   aboutToAppear(): void {//美国
    setInterval(()=>{
      this.getInfo();
      let trailerId=router.getParams() as trailerIdClass
      this.bg=Color.Transparent
    },1000)

  }
  build() {
    Column(){
      Refresh({
        refreshing:$$this.refreshing //显示刷新
      }) {
        Scroll() {
          Stack({alignContent:Alignment.Top}){
            //头部
            Column(){
              Text("超英搜索")
                .fontSize(18)
                .fontWeight(700)
              Row(){
                Image("/images/icos/search.png")
                  .width(20)
                  .onClick(()=>{
                    this.getInfo()
                  })
                TextInput({
                  placeholder:"找预告",
                  text:$$this.data.keywords

                })
                  .id("1")
                  .layoutWeight(1)
                  .backgroundColor(Color.Transparent)
                  .onSubmit(() => {
                    this.getInfo();
                  })
              }
              .backgroundColor(("#f4f6f5"))
              .width("90%")
              .borderRadius(15)
              .padding({left:10})
              .margin({top:10})
            }
            //正文
            List(){
              ListItem(){
                SearchNavBar({
                  SearchData:this.searchData,
                  bg:this.bg
                })
              }
            }
            .height("calc(100% - 135vp)")
            .edgeEffect(EdgeEffect.Fade)
            .position({top:85})
            //底部
            bottomNavBar({
              curIndex:1
            })
          }
          .wh100()
        }
        }
      .onStateChange((state:RefreshStatus)=>{//回调函数二：接受一个state:刷新状态
        this.curRefreshStatus=state;
        if ( state==RefreshStatus.Refresh){
          this.searchData=[new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),new searchDataClass(),]
          this.bg="#fbfbfc"
          setTimeout(async ()=>{
            this.refreshing=false;
            this.getInfo();
            this.bg=Color.Transparent
          },1000)
        }
      })
      }


  }
}