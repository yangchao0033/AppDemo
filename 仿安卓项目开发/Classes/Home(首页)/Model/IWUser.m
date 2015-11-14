//
//  IWUser.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWUser.h"

@implementation IWUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    /** 会员类型 > 2代表是会员 */
    _vip = mbtype > 2;
}

@end
