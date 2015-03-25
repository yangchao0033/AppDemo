//
//  IWHttpTool.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  发送请求

#import <Foundation/Foundation.h>
@class IWUploadParam;

/*
 定义一个叫httpBlock的变量,它是什么类型void(^)(id responseObject)
 void(^httpBlock)(id responseObject) ;
 */

// 给void(^)(id responseObject)block类型取一个别名HttpSuccessOption
// HttpSuccessOption == void (^)(id responseObject)
// 成功的回调类型,传一个返回数据给你
typedef void(^HttpSuccessOption)(id responseObject);
// 失败的回调类型,传一个错误给你
typedef void(^HttpFailureOption)(NSError *error);
// HttpFailureOption void (^)(NSError *error)

@interface IWHttpTool : NSObject


/**
 *  发送get请求
 *
 *  @param URLString  请求的url
 *  @param parameters 请求参数
 *  @param success    成功回调的Block
 *  @param failure    失败回调的Block
 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(HttpSuccessOption)success
                        failure:(HttpFailureOption)failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的url
 *  @param parameters 请求参数
 *  @param success    成功回调的Block
 *  @param failure    失败回调的Block
 */
+ (void)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

+ (void)upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(IWUploadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;
@end
