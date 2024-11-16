import { Login, Regist } from '../api'
import { loginRequestClass, registRequestClass } from '../models'
import { promptAction, router } from '@kit.ArkUI'
import { local } from './myLocalStorage'

@Entry(local)
@Component
struct SuperLogin {
  @State username:string=""
  @State pwd:string=""
  @StorageLink('accessTokenU') accessTokenU:string = '';
  @StorageLink('accessTokenI') accessTokenI:string = "";
  build() {
    Column(){
      //标题
      Row(){
        Image("/images/icos/back.png")
          .width(20)
          .onClick(()=>{
            router.pushUrl({
              url:"pages/superIndex"
            })
          })
        Text("uni-app")
          .fontWeight(900)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width("100%")
      .padding({left:20,right:20})
      .height(50)
      .backgroundColor("#f8f8f8")
      //内容
      Column(){
        //
        Row(){
          Image("/images/icos/default-face.png")
            .width(85)
        }
        .height(200)
        Column(){
          Row(){
            Text("账号")
              .fontSize(20)
            TextInput({
              placeholder:"请输入用户名",
              text:$$this.username
            })
              .backgroundColor(Color.Transparent)
              .placeholderColor("#dddcdc")
          }
          .padding({top:10,bottom:10})
          .borderStyle({
            bottom:BorderStyle.Solid,
          })
          Row(){
            Text("密码")
              .fontSize(20)
            TextInput({
              placeholder:"请输入密码",
              text:$$this.pwd
            })
              .backgroundColor(Color.Transparent)
              .placeholderColor("#dddcdc")
          }
          .padding({top:10,bottom:10})
          .borderStyle({
            bottom:BorderStyle.Solid,
          })
          .borderColor("#eaeae9")

        }
       Row(){
          Button("注册")
            .width(100)
            .onClick(async ()=>{
                let data:registRequestClass={
                  username:this.username,
                  pwd:this.pwd
                }
                let res=await Regist(data)
               // console.log(JSON.stringify(res))
              if (res.protocol41){
                promptAction.showToast({
                  message:"注册成功"
                })
                this.username=""
                this.pwd=""
              }
            })
          Button("登录")
            .width(100)
            .margin({left:10})
            .onClick(async ()=>{
              console.log('..')
              //1.渲染数据类型
              let data:loginRequestClass={
                username:this.username,
                pwd:this.pwd
              }
              //2.调用登录接口
              let res=await Login(data)
              console.log(JSON.stringify(res))
              if (res.id){
                  promptAction.showToast({//
                    message:"登陆成功"
                  })
                this.accessTokenU=res.username
                this.accessTokenI=res.id+""
                router.pushUrl({
                  url:"pages/superMy",
                  // params:{
                  //   username:res.username,
                  //   id:res.id
                  // }
                })
              }

            })
       }
       .margin({top:20})

      }
      .padding({left:20,right:20})
    }


  }
}