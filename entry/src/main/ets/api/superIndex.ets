import {Request} from "../utils/request";
import { carouselListDataClass, chaoyingDataClass, chaoyingRequestClass,
  detailDataClass,
  detailRequestClass,
  likeDataClass,
  staffDataClass,
  staffRequestClass} from "../models";

//首页list的接口 /index/carousel/list
export function CarouselList(){
  return Request.postRequest<carouselListDataClass[], void>("/index/carousel/list")
}
//热门超英
export function reMen(data:chaoyingRequestClass){
  return Request.postRequest<chaoyingDataClass[], chaoyingRequestClass>("/index/movie/hot",data);
}
//热门预告
export function yugao(data:chaoyingRequestClass){
  return Request.postRequest<chaoyingDataClass[], chaoyingRequestClass>("/index/movie/hot",data);
}

//猜你喜欢  /index/guessULike
export function Like(){
  return Request.postRequest<likeDataClass[], void>("/index/guessULike")
}
//详情
export  function Detail(data:detailRequestClass){
  return Request.postRequest<detailDataClass[],detailRequestClass>("/search/trailer",data)
}
//演职人员
export  function Actor(data:staffRequestClass){
  return Request.postRequest<staffDataClass[],staffRequestClass>("/search/staff",data)
}