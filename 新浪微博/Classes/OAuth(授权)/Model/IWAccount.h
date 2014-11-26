//
//  IWAccount.h
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 */
@interface IWAccount : NSObject<NSCoding>

/**
 *  用于调用access_token 一个用户和一个软件就对应一个access_token
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  有效期
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  过期时间
 */
@property (nonatomic, copy) NSDate *expires_date;

/**
 *  当前授权用户的UID == 一个用户对应一个uid
 */
@property (nonatomic, copy) NSString *uid;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
