//
//  IWStatus.h
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 created_at	string	微博创建时间
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 pic_urls	object	微博配图地址。多图时返回多图链接。无配图返回“[]”
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 
 */

@class IWUser,IWPhoto;
@interface IWStatus : NSObject<NSCoding>
//{
//    NSString *_source;
//}
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博作者的用户信息
 */
@property (nonatomic, strong) IWUser *user;
/**
 *  被转发的原微博信息
 */
@property (nonatomic, strong) IWStatus *retweeted_status;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博配图地址
 */
@property (nonatomic, strong) NSArray *pic_urls;



@end
