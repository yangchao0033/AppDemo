//
//  IWAccountTool.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
// 处理账号的业务逻辑

#import "IWAccountTool.h"
#import "IWAccount.h"
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

@end
