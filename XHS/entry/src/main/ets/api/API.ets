import { get,post } from '../utils/HttpUtil'
import http from '@ohos.net.http'
import UserModel from '../model/UserModel'

// 执行注册
export const reg = (params:UserModel):Promise<http.HttpResponse> =>post("/user/reg",params)
// 执行登录
export const login = (params:UserModel):Promise<http.HttpResponse>=>post("/user/login",params)
// 查询搜索历史记录
export const history = ():Promise<http.HttpResponse> =>get("/content/history")
// 查询推荐内容
export const suggestions = ():Promise<http.HttpResponse> =>get("/content/suggestions")
// 查询热点内容
export const hottopics  = ():Promise<http.HttpResponse> =>get("/content/hottopics")

export const items  = ():Promise<http.HttpResponse> =>get("/content/items")