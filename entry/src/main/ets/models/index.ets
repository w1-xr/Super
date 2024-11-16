export * from "./user";
export * from "./superIndex";
export * from "./superSearch"



//返回的数据的类型；
export class ResponseClass<T>{
  code:number=-1;
  msg:string="";
  data?:T;
}