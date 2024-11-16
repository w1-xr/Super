//这里面定义的都是返回的data数据类型T
//登录
export class loginRequestClass{
  username:string="";
  pwd:string=""
}
export class  loginDataClass{//登陆返回数据类型
  id:number=0;
  username:string="";
  pwd:string=""
}

//注册
export class registRequestClass{
  username:string="";
  pwd:string=""
}
export class  registDataClass{//登陆返回数据类型
  fieldCount:number=0
  affectedRows:number=0
  insertId:number=0
  serverStatus:number=0
  warningCount:number=0
  message:string=""
  protocol41:boolean=true
  changedRows:number=0
}





