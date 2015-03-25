//
//  IWUserTool.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWUser,IWUnReadResult;
@interface IWUserTool : NSObject

// block参数设计原理:需要把谁传出去,就填谁
/**
 *  获取用户信息
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)userInfoDidSuccess:(void(^)(IWUser *user))success failure:(void(^)(NSError *error))failure;


/**
 *  获取用户未读数
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)unReadCountDidSuccess:(void(^)(IWUnReadResult *unreadResult))success failure:(void(^)(NSError *error))failure;


@end
