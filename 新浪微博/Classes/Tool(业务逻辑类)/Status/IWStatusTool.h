//
//  IWStatusTool.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  获取微博数据

#import <Foundation/Foundation.h>

@interface IWStatusTool : NSObject


/**
 *  获取更多的微博数据
 *
 *  @param maxID   若指定此参数，则返回ID小于或等于max_id的微博
 *  @param success 成功时候的一个回调
 *  @param failure 失败时候的一个回调
 */
+ (void)moreStatusWithMaxID:(id)maxID success:(void (^)(NSArray *statuses))success failure:(void (^)( NSError *error))failure;



/**
 *  获取更新的微博数据
 *
 *  @param sinceID 若指定此参数，则返回ID比since_id大的微博
 *  @param success 成功时候的回调
 *  @param failure 失败时候的回调
 */
+ (void)newStatusWithSinceID:(id)sinceID success:(void (^)(NSArray *statuses))success failure:(void (^)( NSError *error))failure;

@end
