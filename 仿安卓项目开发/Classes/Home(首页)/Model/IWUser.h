//
//  IWUser.h
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 screen_name	string	用户昵称
 profile_image_url	string	用户头像地址（中图），50×50像素
 */
@interface IWUser : NSObject

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户头像URl
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;

// 判断是不是会员
@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
