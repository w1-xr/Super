
class localClass{
  accessTokenU:string=""
  accessTokenI:string=""
  accessTokenB:string|Date=new Date().toLocaleDateString()
  accessTokenS:string="请选择"
  Zindex:number=10
}

let localObj:localClass={
  accessTokenU:"",
  accessTokenI:"",
  accessTokenB:new Date().toLocaleDateString(),
  accessTokenS:"请选择",
  Zindex:10

}
export const local=new LocalStorage(localObj)