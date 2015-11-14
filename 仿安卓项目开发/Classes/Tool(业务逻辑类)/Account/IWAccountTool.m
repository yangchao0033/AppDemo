//
//  IWAccountTool.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
// 处理账号的业务逻辑

#import "IWAccountTool.h"
#import "IWHttpTool.h"
#import "IWAccountParam.h"
#import "MJExtension.h"

#define IWAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation IWAccountTool

+ (void)save:(IWAccount *)account
{
    // 存储账号
    [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
}

+ (IWAccount *)account
{
    IWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    
    // 账号过期 过期时间 11:25  > 11:24 没有过期
    // 小于当前时间 过期
    // NSOrderedAscending = -1L, 升序 1~10
    // NSOrderedDescending 降序 10 ~1

    if ([account.expires_date compare:[NSDate date]] == NSOrderedAscending) { // 过期
        
        account = nil;
    }
    
    return account;
}

+ (void)accessTokenWithCode:(id)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    IWAccountParam *param = [[IWAccountParam alloc] init];
    param.client_id = IWAppkey;
    param.client_secret = IWAppSecture;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = IWRedirectUrl;
    // 发送post -> HttpTool
    [IWHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 成功获取accessToken
        // 字典转模型
        // 创建账号
        IWAccount *account = [IWAccount accountWithDict:responseObject];
        NSLog(@"%@", account.uid);
        // 保存模型到沙盒
        [IWAccountTool save:account];
        
        if (success) {
            success();
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
