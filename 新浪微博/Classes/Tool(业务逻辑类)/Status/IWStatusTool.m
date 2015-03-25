//
//  IWStatusTool.m
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatusTool.h"
#import "IWHttpTool.h"
#import "IWAccountTool.h"
#import "IWStatus.h"
#import "MJExtension.h"
#import "IWStatusParam.h"
#import "IWStatusResult.h"
#import "IWStatusCacheTool.h"

@implementation IWStatusTool

//获取更新的微博数据
+ (void)newStatusWithSinceID:(id)sinceID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    IWStatusParam *param = [[IWStatusParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    
    
    // 判断sinceID有没有值
    if (sinceID) {
        // 拼接sinceId参数
        param.since_id = sinceID;
    }
    
    // 先从本地数据库读取
    NSArray *statuses = [IWStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
        
    }
    
    
    // 发送
    // 注意这里需要模型转字典 因为AFN底层只能拿到字典去拼接
    // param.keyValues 直接把模型转换成字典
    [IWHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        IWStatusResult *result = [IWStatusResult objectWithKeyValues:responseObject];
        
        // 把微博数据存储到本地数据库
        [IWStatusCacheTool saveStatuses:result.statuses];

        if (success) {
            success(result.statuses);
        }

        
    } failure:^(NSError *error) {
        
    }];
}

// 获取更多的微博数据
+ (void)moreStatusWithMaxID:(id)maxID success:(void (^)(NSArray *statuses))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    IWStatusParam *param = [[IWStatusParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;;


    if (maxID) {
        // 拼接max_id参数
        param.max_id = maxID;
    }
    
    
    // 先从本地数据库读取
    NSArray *statuses = [IWStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
        
    }
    
    // 发送get请求
    [IWHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) { // http获取成功的时候调用这个block
        
        // 字典转模型
        IWStatusResult *result = [IWStatusResult objectWithKeyValues:responseObject];
        
        // 把微博数据存储到本地数据库
        [IWStatusCacheTool saveStatuses:result.statuses];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
