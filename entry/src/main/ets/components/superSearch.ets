import { searchDataClass } from '../models'
import { router } from '@kit.ArkUI'

@Component
struct SearchNavBar{
  @Prop SearchData:searchDataClass[]=[]
  @Prop bg:ResourceColor
  build() {
    Grid(){
      ForEach(this.SearchData,(item:searchDataClass)=>{
        GridItem(){
          Image(item.poster)
            .height(150)
            .onClick(()=>{
              router.pushUrl({
                url:"pages/superDetail",
                params:{
                  trailerId:item.id,
                  url:"pages/superSearch"
                }
              })
            })
        }
        .backgroundColor(this.bg)
      })
    }
    .columnsTemplate("1fr 1fr 1fr")
    .rowsGap(10)
    .columnsGap(10)
    .padding(15)
    .backgroundColor("#f0f0f0")
  }

}
export {SearchNavBar}