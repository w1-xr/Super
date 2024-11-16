export class bottomType{
  icon:ResourceStr=""
  selectedIcon:ResourceStr=""
  name:ResourceStr=""
  url:string=""
}

//首页list
export class carouselListDataClass{
  movieId:number=0;
  image:string=""
}

@Observed
export  class carouselListDataType{
  movieId:number;
  image:string

  constructor(movieId:number,image:string) {
    this.movieId=movieId
    this.image=image
  }
}

//热门超英/预告
export class  chaoyingRequestClass{
  type:string=""
}

export class chaoyingDataClass{
  id?:number
  trailer?:string
  plotPics?:string
  poster?:string
  cover?:string
  name?:string
  basicInfo?:string
  originalName?:string
  totalTime?:string
  releaseDate?:string
  score?:string
  plotDesc?:string
  type?:string

  constructor( id?:number, trailer?:string, plotPics?:string, poster?:string, cover?:string, name?:string, basicInfo?:string, originalName?:string, totalTime?:string, releaseDate?:string, score?:string, plotDesc?:string, type?:string,) {
    this.id=id
    this.trailer=trailer
    this.plotPics=plotPics
    this.poster=poster
    this.cover=cover
    this.name=name
    this.basicInfo=basicInfo
    this.originalName=originalName
    this.totalTime=totalTime
    this.releaseDate=releaseDate
   this.score= score
    this.plotDesc=plotDesc
    this.type=type
  }
}

//猜你喜欢
export class likeDataClass{
  id?:number
  cover?:string
  name?:string
  score?:string
  basicInfo?:string
  releaseDate?:string

  constructor( id?:number, cover?:string, name?:string, score?:string, basicInfo?:string, releaseDate?:string,) {
    this.id=id
    this.cover= cover
    this.name=name
    this.score=score
    this.basicInfo=basicInfo
    this.releaseDate=releaseDate
  }
}

//详情
export class detailRequestClass{
  trailerId:number=0
}
export class detailDataClass{
  id:number=0
  trailer:string=""
  plotPics:string=""
  poster:string=""
  cover:string=""
  name:string=""
  basicInfo:string=""
  originalName:string=""
  totalTime:string=""
  releaseDate:string=""
  score:string=""
  plotDesc:string=""
  type:string=""
}
//演职人员
export class staffRequestClass{
  trailerId:number=0;
  role:string='1';
}
export class staffDataClass{
  photo:string="";
  actName:string="";
  name:string=""
}