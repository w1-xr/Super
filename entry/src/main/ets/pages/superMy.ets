import { bottomNavBar } from '../components/superIndex'
import { router } from '@kit.ArkUI';

@Styles function wh100(){
  .width("100%")
  .height("100%")
}
class loginClass{
  username:string=""
  id:string=""
}
@Entry
@Component
struct SuperMy {
  @StorageLink('accessTokenU') accessTokenU:string = '';
  @StorageLink('accessTokenI') accessTokenI:string = "";
  @State con:string="登陆/注册"
  @State icon2:string="/images/icos/settings.png"
  @State icon1:string="/images/icos/108x108.png"
  aboutToAppear(): void {
   if (this.accessTokenU){
     this.con=""
     this.icon1="/images/icos/default-face.png"
   }else {
     this.icon2=""
   }
  }

  @Builder top(icon1:string,username?:string,ID?:string,con?:ResourceStr,icon2?:string){
    Column(){
      Row(){
        Image(icon1)
          .width(50)
          .borderRadius(25)
        Column(){
          Text(username)
            .fontSize(18)
            .fontWeight(900)
          Text(ID)
            .fontColor(Color.Gray)
            .margin({top:5})
          Text(con)
            .fontSize(18)
        }
        .width("100%")
        .alignItems(HorizontalAlign.Start)
        .margin({left:30})
        .layoutWeight(1)
        Image(icon2)
          .width(20)
      }
      .justifyContent(FlexAlign.Start)
      .height(110)
      .backgroundColor("#ffd655")
      .width("100%")
      .padding({left:20,right:20})
    }
  }
  build() {
    Stack({alignContent:Alignment.Top}){
      //头部
      Row(){
        this.top(this.icon1,this.accessTokenU,this.accessTokenI,this.con,this.icon2)
      }
      .onClick(()=>{
        console.log(this.accessTokenU)
        if (this.accessTokenU){
          router.pushUrl({
            url:"pages/superEdit"
          })
        }else {
          router.pushUrl({
            url:"pages/superLogin"
          })
        }

      })


      //正文

      //底部
      bottomNavBar({
        curIndex:2
      })
    }
    .wh100()

  }
}