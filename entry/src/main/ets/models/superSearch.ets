export class searchRequestClass{
  keywords:string=""
  page?:number=1
  pageSize?:number=10
}

export class searchDataClass{
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