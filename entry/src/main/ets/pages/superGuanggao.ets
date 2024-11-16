import { router } from '@kit.ArkUI';
PersistentStorage.persistProp('haslunbo', 'nohas');//没显示过
@Entry
@Component
struct SuperGuanggao {
  lunboData:string[]=["/images/poster/civilwar.jpg","/images/poster/justice.png","/images/carousel/batmanvssuperman.png"]
  @State haslunbo:string | undefined = AppStorage.get('haslunbo');//记录是不是有轮播展示
  @State count:number=5;//倒计时时间5秒
  timer:number=0;
  aboutToAppear(): void {//一进来计时器开始
    this.timer=setInterval(()=>{
      if(this.count<=1 &&this.haslunbo=="has"){
        clearInterval(this.timer)
        router.pushUrl({
          url:"pages/superIndex"
        })
      }else {
        this.count--;
      }
    },1000)
  }
  build() {
    Column(){
      if (this.haslunbo=="nohas"){
      //轮播图
      Swiper(){
          ForEach(this.lunboData,(item:string,index:number)=>{
            Stack({alignContent:Alignment.Bottom}){
              //图片
              Image(item)
                .width("100%")
                .height("100%")
              if (index==this.lunboData.length-1){
                //button
                Button("进入应用")
                  .backgroundColor("rgba(0,0,0,0.5)")
                  .position({bottom:20,right:20})
                  .onClick(()=>{
                    AppStorage.setOrCreate('haslunbo', 'has');
                    router.pushUrl({
                      url:"pages/superIndex"
                    })
                  })
              }
            }
          })
        }
       .indicator(
         new DotIndicator()
           .selectedColor("rgba(255,255,255,0.8)")
       )
      .effectMode(EdgeEffect.None)
      .loop(false)
      .width("100%")
      .height("100%")
      }else {
        Column(){
          Stack({alignContent:Alignment.Top}){
            Image("/images/icos/guanggao.jpg")
              .width("100%")
              .height("100%")
            Row(){
              Text(this.count+"")
                .fontColor(Color.White)
              Text("跳过")
                .margin({left:5})
                .fontColor(Color.White)
                .onClick(()=>{
                  router.pushUrl({
                    url:"pages/superIndex"
                  })
                })

            }
            .padding({top:5,bottom:5,left:10,right:10})
            .borderRadius("50%")
            .position({right:10,top:80})
            .backgroundColor("rgba(0,0,0,0.4)")


          }
        }
        .width("100%")
        .height("100%")
      }


    }

  }
}
