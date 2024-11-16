import { router } from '@kit.ArkUI';

@Entry
@Component
struct SuperEditname {
  @State flag:boolean=false
  @StorageLink('accessTokenU') accessTokenU:string = "";
  @StorageLink('accessTokenI') accessTokenI:string = "";
  build() {
    Column(){
      Row(){
        Image("/images/icos/back.png")
          .width(20)
          .onClick(()=>{
            router.pushUrl({
              url:"pages/superEdit"
            })
          })
        Text("修改名字")
          .fontSize(18)
        Button("保存")
          .fontColor(this.flag==false?Color.Pink:"#f53c65")
          .enabled(this.flag)
          .backgroundColor(Color.White)
          .onClick(()=>{
            router.pushUrl({
              url:"pages/superEdit"
            })
          })
      }
      .height(30)
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
       Row(){
         Text("我的名字")
           .fontSize(18)
       }
       .margin({top:15,bottom:10})
      .width("100%")
      TextInput({
        text:$$this.accessTokenU
      })
        .onChange(()=>{
          console.log(this.flag+"")
          this.flag=true
        })
    }
    .padding({left:20,right:20})
  }
}