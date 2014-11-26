//
//  IWAccount.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWAccount.h"

#define IWAccessToken @"access_token"
#define IWUid @"uid"
#define IWExpiresIn @"expires_in"
#define IWExpiresDate @"expires_date"

@implementation IWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    IWAccount *account = [[self alloc] init];
    
    // 作用:利用KVC把字典里的值转换成模型的值
    // KVC原理: KVC底层:把字典里面的所有key遍历,去找模型里面有没有这个属性名,有就直接转,没有就会
    // 用KVC注意:字典里面的key跟模型里面属性名要一一对应
//    [account setValuesForKeysWithDictionary:dict];
    account.access_token = dict[IWAccessToken];
    account.uid = dict[IWUid];
    account.expires_in = dict[IWExpiresIn];
    
    return account;
}

// 设置有效期,就算下过期时间
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 过期时间 = 当前时间 + 有效期
    NSDate *date = [NSDate date];
    
    // 在date这个时间上加上有效期
    _expires_date = [date dateByAddingTimeInterval:[expires_in longLongValue]];
}

// 告诉系统哪些属性需要归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:IWAccessToken];
    [aCoder encodeObject:_uid forKey:IWUid];
    [aCoder encodeObject:_expires_in forKey:IWExpiresIn];
    [aCoder encodeObject:_expires_date forKey:IWExpiresDate];
}

//  告诉系统哪些属性需要解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _expires_in = [aDecoder decodeObjectForKey:IWExpiresIn];
        _access_token = [aDecoder decodeObjectForKey:IWAccessToken];
        _uid = [aDecoder decodeObjectForKey:IWUid];
        _expires_date = [aDecoder decodeObjectForKey:IWExpiresDate];
    }
    return self;
}

@end
