//
//  IWHttpTool.m
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHttpTool.h"
#import "AFNetworking.h"
#import "IWUploadParam.h"


@implementation IWHttpTool
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送get请求
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) { // AFN请求成功的回调

        // 请求成功,把数据返回出去
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送post请求 -> 获取accessToken
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功的时候回调
        if (success) {
            success(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { //请求
        if (failure) {
            failure(error);
        }
    }];

}


+ (void)upload:(NSString *)URLString parameters:(id)parameters uploadParam:(IWUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 发送post请求 上传图片只能用这个方法
    // pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
    // 拼接一个二进制数据:网络传输中文件都是以二进制格式传输
    // 二进制文件不能当做普通参数拼接,http协议不支持这种拼接格式
    // 上传文件 一定用这个multipart
    
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {// 在这个block就是专门用来拼接二进制数据
        
        // 拼接二进制
        
      
        // 这里为什么要设计模型,如果一个方法需要传很多参数,应该把这些参数包装成一个模型
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.paramName fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
      
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}



@end
