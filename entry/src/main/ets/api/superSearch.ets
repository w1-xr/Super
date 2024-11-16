import { searchDataClass, searchRequestClass } from '../models'
import { Request } from '../utils/request'

export function Search(data:searchRequestClass){
   return Request.postRequest<searchDataClass[],searchRequestClass>("/search/list",data)
}