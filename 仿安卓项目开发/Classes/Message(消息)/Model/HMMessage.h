//
//  HMMessage.h
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HMMessageTypeMe = 0, // 表示自己
    HMMessageTypeOther = 1 // 表示对方
} HMMessageType;


@interface HMMessage : NSObject

// 消息正文
@property (nonatomic, copy) NSString *text;

// 发送时间
@property (nonatomic, copy) NSString *time;

// 消息的类型
@property (nonatomic, assign) HMMessageType type;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
