import { router } from '@kit.ArkUI';
import { picker } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
@Styles function te(){
  .width("100%")
  .height(45)
  .backgroundColor(Color.White)
}
@Extend(Column) function globalcolumnStyle(){
  .borderRadius(15)
  .width("100%")
  .backgroundColor("#f8f8fa")
  .height(180)

}
@Extend(Text) function globalTextStyle(){
  .textAlign(TextAlign.Center)
  .width("100%")
  .height(60)
  .fontColor(Color.Blue)
}
class buildertype{
  textt:string=""
  icon?:string=""
  texttt?:string|Date
}
@Entry
@Component
struct SuperEdit {
  @StorageLink('accessTokenU') accessTokenU:string = "";
  @StorageLink('accessTokenI') accessTokenI:string = "";
  @StorageLink('accessTokenB') accessTokenB:Date=new Date();
  @StorageLink('accessTokenS') accessTokenS:string = "";
  @State birthday:Date=new Date("1900-01-01")
  @State texttt:string=""
  @State touxiang:string="/images/icos/default-face.png"
  @State bottomm:number=-180
  @State bottomm2:number=-180

  ani(){
    animateTo({
      duration:500,
      curve:Curve.Linear
    },()=>{
      this.bottomm=this.bottomm==-180?0:-180
    })
}
  aboutToAppear(): void {
    if (this.accessTokenU){
      this.texttt=this.accessTokenU
    }
  }
  @Builder hasaccessTokenlist($$:buildertype){
    Row(){
      Text($$.textt)
      Row(){
        Image($$.icon)
          .width(30)
        if ($$.texttt instanceof Date)
          Text($$.texttt.toLocaleDateString())
            .fontColor(Color.Gray)
        else
          Text($$.texttt+"")
            .fontColor(Color.Gray)
      }
      .layoutWeight(1)
     .justifyContent(FlexAlign.End)

      Image("/images/icos/left-gray-arrow.png")
        .width(15)
    }
    .backgroundColor(Color.White)
    .height(45)
    .width("100%")
    .padding({left:20,right:20})
  }
  @Builder hasaccessToken(){
    Column(){
      Row(){
        Image("/images/icos/back.png")
          .width(25)
      }
      .padding({left:15,bottom:10})
      .width("100%")
      .backgroundColor(Color.White)
      .onClick(()=>{
        router.pushUrl({
          url:"pages/superMy"
        })
      })

      Row(){this.hasaccessTokenlist({textt:"头像",icon:this.touxiang,texttt:""})}
      .onClick(async()=>{
        //1.1四步走
        let options=new picker.DocumentSelectOptions();
        let context=getContext(this) as common.Context
        let pickView=new picker.DocumentViewPicker(context);//1
        let res:string[]=await pickView.select(options)//2
        //1.3
        /*AlertDialog.show({
         message:JSON.stringify(res)
       })*/
        this.touxiang=res[0]
      })
      Row(){this.hasaccessTokenlist({textt:"昵称",icon:"",texttt:this.accessTokenU})}
      .onClick(()=>{
        router.pushUrl({
          url:"pages/superEditname"
        })
      })
      Row(){ this.hasaccessTokenlist({textt:"生日",icon:"",texttt:this.accessTokenB})}
      .onClick(()=>{
        DatePickerDialog.show({
          selected:this.birthday, //选择的日期，当前日期
          lunar:false,//日期不显示为农历
          onDateAccept:(value:Date)=>{//点击弹窗中的“确定”按钮时触发该回调。
            this.birthday=value
            this.accessTokenB=value
            console.log(value.toLocaleString())
          },
        })
      })
      Row(){  this.hasaccessTokenlist({textt:"性别",icon:"",texttt:this.accessTokenS})}}
        .onClick(()=>{
         this.ani()
        })
  }
  build() {
    Stack({alignContent:Alignment.Top}){
      Column(){

      }
      .width("100%")
      .height("100%")
      .backgroundColor("#f0f0f0")
      Column(){
        this.hasaccessToken()
      }
      .backgroundColor(Color.Transparent)

      Column({space:5}){
        Text("清理缓存")
          .textAlign(TextAlign.Center)
          .te()
          .onClick(()=>{
           this.accessTokenB=new Date()
           this.accessTokenS="请选择"
          })
        Text("退出登录")
          .textAlign(TextAlign.Center)
          .te()
          .onClick(()=>{
            this.accessTokenU=""
            this.accessTokenI=""
            router.pushUrl({
              url:"pages/superLogin"
            })
          })
      }
      .position({bottom:0})

      Column(){
        Text("男")
          .globalTextStyle()
          .onClick(()=>{
            this.accessTokenS="男"
            this.ani()
          })
        Text("女")
          .globalTextStyle()
          .border({
            width:1,
            color:"#e7e8e8"
          })
          .onClick(()=>{
            this.accessTokenS="女"
            this.ani()
          })

        Text("取消")
          .globalTextStyle()
          .onClick(()=>{
            this.ani()
          })

      }
      .globalcolumnStyle()
      .position({
        bottom:this.bottomm
      })



    }
  }
}