import { get,post } from '../utils/HttpUtil'
import http from '@ohos.net.http'
import UserModel from '../model/UserModel'
//请求获取组织数据
export const departments = ():Promise<http.HttpResponse> =>get("/department")
// 执行注册
export const reg = (params:UserModel):Promise<http.HttpResponse> =>post("/user/reg",params)
// 执行登录
export const login = (params:UserModel):Promise<http.HttpResponse>=>post("/user/login",params)