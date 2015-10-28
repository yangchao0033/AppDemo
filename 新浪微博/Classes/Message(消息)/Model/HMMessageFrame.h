//
//  HMMessageFrame.h
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#define HMTextFont [UIFont systemFontOfSize:12]
@class HMMessage;
@interface HMMessageFrame : NSObject

// 引用数据模型
@property (nonatomic, strong) HMMessage *message;

// ------------ 声明与控件相对应的frame属性 ---------------

// 发送时间
@property (nonatomic, assign, readonly) CGRect timeFrame;

// 头像
@property (nonatomic, assign) CGRect iconFrame;


// 消息正文
@property (nonatomic, assign, readonly) CGRect textFrame;


// 行高
@property (nonatomic, assign, readonly) CGFloat cellHeight;

// 是否需要隐藏时间Label
@property (nonatomic, assign) BOOL hideTime;



@end






