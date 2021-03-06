//
//  笔记.h
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

/*
一.UITabBar上的按钮由谁决定:由tabBarController控制器对应的子控制器的tabBarItem(模型),MVC思想,改变模型就能改变视图
 
 
二.怎么看是不是系统自带的模型:
 1.看名称带有Item就是模型
 2.还可以跳入头文件,只要继承NSObject
 3.系统自带的item,要想设置对应控件的标题颜色,只能设置item的富文本属性(丰富文本)
 
 使用UICollectionViewController的条件
 注意:self.view != self.collectionView
 
 1.必须要有布局参数,默认使用流水布局
 2.cell必须注册,不能alloc init创建,其实默认storyboard内部实现就是注册机制
 3.默认系统自带的cell不好用,必须自定义cell
 
三. OAuth授权笔记:
 
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
 
 
 
 处理网络请求:
 1.明确请求方式:post,get,
 2.明确用什么去请求:AFN->做网络的请求
 3.发送请求(1.创建管理者2.拼接参数3.发送请求)
 4.解析返回数据(查看API)
 5.字典转模型(根据返回的数据,设计模型),只需要搞有用的数据
 
 
 把模型数据展示到界面
 
 SDWebImage框架:
 
 
 网络请求封装思想:
 1.设计请求的参数模型
 2.设置返回的结果模型
 3.搞一个工具类处理请求,直接获取想要的数据
 4.工具类方法设计原理:必须请求成功和失败的回调block,需要的可变参数(sinceid,maxid,code)
 5.block设计原理:没有返回值,参数:想把谁传出去,就添谁
 
 
 处理微博cell
 1.判断系统自带符不符合需求,如果不符合,自定义cell
 2.cell内部有很多子控件,包括以后一个界面有很大子控件,一定要有分层思想
 3.如何分层:根据数据的内容分层
 4.确定分层,想都不用想,直接在创建Cell的时候,把所有子控件添加上面(3个子控件)
 
 MVVM思想:M:modal模型 V:view视图 VM:viewModal视图模型
 VM:模型+视图的frame(只要视图的frame由数据决定,就能使用这种)
 
 怎么去使用这种思想:当一有数据的时候,就把模型转换成视图模型
 解决问题:避免循环利用控件的时候,每次都去计算尺寸,这种非常消耗资源
 
 
 什么时候重写get,set方法
 get,如果在每次获取的时候都要做一些与当前时间相关的判断处理,就重写get,相反,用set
 

 Bug1:快速双击首页,意味马上加载两次更新的微博,发送了两个参数sinceID=100 请求 延迟1分钟 数组里面的最新的微博 100 新的数据还没有加入微博数组中 > 100
     假设网速超慢:点击首页,加载更新的微博,参数sinceID 100 > 100
 怎么解决:
 1.第一次点击首页,直接让首页按钮不允许交互,用GCD延迟1秒,1秒后就让首页允许交互
 
 2.记录一下数组中第一个微博数据的sinceID,当发送请求之前,判断两个sinceId是否相等,如果相等,就发送请求.(非常傻逼)
 3.搞一个成员变量,记录住当前是否正在刷新ing,当前正在刷新,就不发送请求
 
 Bug2:提示有未读的微博数据,但是我上啦刷新更多的时候,未读数就没了,这是新浪后台的问题,它只要一请求微博,就会把未读数清空.
1.告诉后台哪个sb给改一改,不要一请求微博就把未读数给我清空.
2.自己记录,有种情况后台不配合,就只能自己记录.
 
 
 // 在ios8里面,默认就会后台运行
 // 在ios8之前,所有程序进入后台,就会达到休眠状态,也就说不会做任何的事件处理
 
 iOS7怎么做后台运行处理
 1.开启一个后台任务
 2.配置Info.plist,告诉系统后台的模式(音乐,GPS等等)
 3.如果后台模式使用音乐,就要真正的播放音乐,要不然苹果发现你的程序没有播放音乐,一样把你挂掉
 在哪做后台运行处理,程序一进入后台的时候,会调用applicationdelegate的一个方法,在这里做处理
 
 
 什么时候用代理,block,通知
 代理:一般封装控件的时候用代理,方便通知外界做很多事情,以后控件的扩展,以后只要有新的事件需要通知外界,只需要提加一个协议方法.
 block:一般用来数据传递,(回传)
 通知:让两个没有关联的东西,产生联系,就用通知,也就是谁也拿不到谁的时候.
 一对多,发出一个通知,多个对象处理.
 
 循环利用问题:
 如果一个控件,经常循环利用,就不能在给这个控件赋值属性的时候,添加它的子控件,应该在初始化这个控件的时候就把所有的子控件添加上去.
 注意在循环利用中,只要有if,就必须加上else,else一般做什么事情,把之前的状态清空,其实就是还原最开始的状态.
 
 什么时候用静态单元格:如果界面cell跟系统自带的cell完全差不多,就可以选择静态单元格.
 如果不相似:
 1.判断其他cell是否全部差不多的界面,如果全部差不多,就可以使用静态单元格
 2.如果界面差别很大,就不使用静态单元格,就用代码.
 
 假如让你从零开始写一个项目,你什么怎么开始的,怎么去搭建界面
 1.观察原型图
 2.找相同的界面,目的是抽出一个基类模块,只要我写好这个控制器,其他的全部写好.
 3.判断是用纯代码还是storyboard搭建这个模块,如果界面的控件位置都是固定,用storyboard
 
 
 为什么跳转控制器用Class
 如果用NSString,
 1.没有提示
 2.还需要多做一步操作,把字符串转成Class
 3.写错了控制器的名字,也不会报错
 
 */
