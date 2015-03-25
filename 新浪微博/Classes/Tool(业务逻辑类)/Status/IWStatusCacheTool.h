//
//  IWStatusCacheTool.h
//  新浪微博
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  处理微博数据库的业务逻辑
//  存储微博模型
//  读取微博模型

#import <Foundation/Foundation.h>
@class IWStatusParam;
@interface IWStatusCacheTool : NSObject

// 存储所有的微博数据
+ (void)saveStatuses:(NSArray *)statuses;

+ (NSArray *)statusesWithParam:(IWStatusParam *)param;



@end
