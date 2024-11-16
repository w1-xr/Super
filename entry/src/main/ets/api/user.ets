import {Request} from "../utils/request";
import {
  likeDataClass,
  loginDataClass, loginRequestClass,
  registDataClass,
  registRequestClass,
  staffDataClass,staffRequestClass} from "../models";

//登录的接口
export function Login(data:loginRequestClass){
  return Request.postRequest<loginDataClass, loginRequestClass>("/login",data);
}

//注册的接口
export function Regist(data:registRequestClass){
  return Request.postRequest<registDataClass, registRequestClass>("/register",data);
}




