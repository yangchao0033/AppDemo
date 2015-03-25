//
//  IWAccountTool.h
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWAccount.h"
@class IWAccount;
@interface IWAccountTool : NSObject


+ (void)save:(IWAccount *)account;
+ (IWAccount *)account;

/**
 *  获取accessToken
 *
 *  @param code    requestToken
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)accessTokenWithCode:(id)code success:(void (^)())success failure:(void (^)( NSError *error))failure;

@end
