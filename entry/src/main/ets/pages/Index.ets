// import http from '@ohos.net.http';
// import { promptAction } from '@kit.ArkUI';
// import {Login,Staff,CarouselList, Like} from "../api";
// import { carouselListDataClass, likeDataClass, loginRequestClass, staffDataClass,staffRequestClass } from '../models';
//
// @Entry
// @Component
// struct Index {
//   @State username:string="";
//   @State pwd:string=""
//   @State daoyanRes:staffDataClass[]=[]
//   @State staffArr:staffDataClass[]=[]
//   @State list:carouselListDataClass[]=[]
//   @State likeList:likeDataClass[]=[]
//
//   async aboutToAppear(): Promise<void> {
//     this.list=await CarouselList()
//     this.likeList=await Like()
//   }
//   build() {
//     Scroll() {
//       Column(){
//         //1.登录（需要传参）
//         TextInput({
//           text:$$this.username
//         })
//         TextInput({
//           text:$$this.pwd
//         })
//         Button("登录")
//           //1.1先渲染要输入的data数据类型
//           .onClick(async ()=>{
//             let data:loginRequestClass={
//               username:this.username,
//               pwd:this.pwd
//             }
//             //2.调用登录接口
//             let res=await Login(data)
//             console.log(JSON.stringify(res))
//             if (res.id){
//               AlertDialog.show({
//                 message:"登陆成功"
//               })
//             }
//           })
//         //2.获取导演信息
//         Button("获取导演信息")
//           .onClick(async ()=>{//1.渲染传入数据
//             let data:staffRequestClass={
//               trailerId:1001,
//               role:"1"
//             }
//             this.daoyanRes=await Staff(data)//2.调用接口
//             console.log(JSON.stringify(this.daoyanRes[0]))
//           })
//         if (this.daoyanRes[0]){
//           Row(){
//             Image(this.daoyanRes[0].photo)
//               .width(50)
//             Column(){
//               Text(this.daoyanRes[0].actName)
//               Text(this.daoyanRes[0].name)
//             }
//           }
//         }
//
//         //3.获取首页轮播图
//         Swiper(){
//           ForEach(this.list,(item:carouselListDataClass)=>{
//             Image(item.image)
//               .width("100%")
//           })
//         }
//         .width("100%")
//         .height(200)
//         .autoPlay(true)
//
//         //4.获取猜你喜欢
//         if (this.likeList){
//           ForEach(this.likeList,(item:likeDataClass)=>{
//             Column(){
//               Image(item.cover)
//                 .width(130)
//               Text(item.name)
//               Text(item.score)
//               Text(item.basicInfo)
//               Text(item.releaseDate)
//             }
//           })
//         }
//       }
//     }
//     .height('100%')
//     .width('100%')
//   }
// }