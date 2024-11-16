import { http } from '@kit.NetworkKit'
import { BASE_URL } from '../constants'
import { ResponseClass } from '../models'
import { moger } from './moger'
import { promptAction } from '@kit.ArkUI'


//封装http请求
//1.创建
const  httpRequest=http.createHttp()

//2.总的get和post
//2.1定义函数
async function requestFn<T, V>(url:string,method:http.RequestMethod,data?:V):Promise<T>{//T:表示返回值的类型；
  let requestUrl=BASE_URL+url

  if (method==http.RequestMethod.GET && data && JSON.stringify(data)!="{}"){
    requestUrl+="?"+moger<V>(data)
  }
  let config:http.HttpRequestOptions={
    header:{
      "content-Type":"application/json"
    },
    method:method
  }
  if (method==http.RequestMethod.POST && data &&JSON.stringify(data)!="{}"){
    config.extraData=data;
  }
  //2.2,成功了做什莫，失败了做什莫
  try {
    let res = await httpRequest.request(requestUrl, config)
    let result=res.result as string
    let rRes=JSON.parse(result) as ResponseClass<T>
    if (rRes.code==200){
      return rRes.data as T;
    }else {
      promptAction.showToast({
        message:rRes.msg
      })
      return Promise.reject(new Error(rRes.msg))
    }
  } catch (e) {
    promptAction.showToast({
      message: e
    })
    return Promise.reject(new Error(e))
  }
}

//3.分的get post
export class Request{
  static getRequest<T, V>(url:string,data?:V):Promise<T>{
    return requestFn<T, V>(url,http.RequestMethod.GET,data)
  }
  static postRequest<T, V>(url:string,data?:V):Promise<T>{
    return requestFn<T, V>(url,http.RequestMethod.POST,data)

  }
}