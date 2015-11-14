//
//  IWUserTool.m
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWUserTool.h"
#import "IWHttpTool.h"
#import "IWUserParam.h"
#import "IWAccountTool.h"
#import "MJExtension.h"
#import "IWUser.h"
#import "IWUnReadResult.h"
@implementation IWUserTool

+ (void)userInfoDidSuccess:(void (^)(IWUser *))success failure:(void (^)(NSError *))failure
{
    IWUserParam *param = [IWUserParam param];
    param.uid = [IWAccountTool account].uid;
    // 发送 get请求 -> httpTool
    [IWHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) { // http成功就会把responseObject传递
        
        // 把字典转换模型
        IWUser *user = [IWUser objectWithKeyValues:responseObject];
        
        // 获取账号模型
        IWAccount *account = [IWAccountTool account];
        if (![user.name isEqualToString:account.name]) {
            // 保存
            account.name = user.name;
            [IWAccountTool save:account];
        }
        
        if (success) {
            success(user);
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)unReadCountDidSuccess:(void (^)(IWUnReadResult *))success failure:(void (^)(NSError *))failure
{
    IWUserParam *param = [IWUserParam param];
    param.uid = [IWAccountTool account].uid;
    [IWHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转模型
        IWUnReadResult *result = [IWUnReadResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
