//
//  IWComposeTool.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseParam.h"

@interface IWComposeTool : IWBaseParam

/**
 *  发送文字微博
 *
 *  @param status  微博内容
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)composeWithStatus:(id)status success:(void (^)())success failure:(void (^)(NSError *error))failure;


/**
 *  发送文字和图片微博
 *
 *  @param status  微博内容
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)composeWithImage:(UIImage *)image status:(id)status  success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
