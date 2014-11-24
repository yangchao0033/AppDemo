//
//  笔记.h
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

/*
    UITabBar上的按钮由谁决定:由tabBarController控制器对应的子控制器的tabBarItem(模型),MVC思想,改变模型就能改变视图
 
 OAuth授权笔记:
 
 OAuth优点:保证用户信息安全
 
OAuth条件:不是任何软件都能OAuth授权
    1.必须要有微博账号 itcastweibo@163.com itcast
 
    2.在开放平台上创建应用,只要在微博开放平台创建的应用,才能OAuth授权
    应用地址:公司官网
 
    3.换取 accessToken
     应用的信息:
     App Key：
     314802966
     
     App Secret：
     15444cae46c944a3753642461c4502a5
 
     目前只是测试应用:不是所有的用户都能授权成功,只有自己的账号才可以授权成功
 
 
 授权步骤总结就3点：
 1> 获取未授权的Request Token -> 展示登录界面
   基本url =  https://api.weibo.com/oauth2/authorize
 client_id 	true 	string 	申请应用时分配的AppKey。
 redirect_uri 	true 	string 	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
 回调地址:登录成功之后进入的网页
 
 完整的url = 基本的url + 参数
 https://api.weibo.com/oauth2/authorize?client_id=314802966&redirect_uri=http://www.baidu.com
 
 2> 获取用户授权的Request Token  -> 只有登录成功才能获取Request Token
 code=
 3> 用授权的Request Token换取Access Token

 
 错误
 invalid_request 非法的请求,url错误,url不完整
 
 */
