export function moger<T>(data:T){//{a:1,b:2}-->a=1 & b=2
  let res:string[] = [];
  if (data instanceof Object) {
    let keys = Reflect.ownKeys(data as object) as string[]
    for (let key of keys) {
      res.push(key + '=' + (data as object)[key])
    }
    return res.join('&');
  }
  return '';
}