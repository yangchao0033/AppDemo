//
//  IWUserInfo.h
//  新浪微博
//
//  Created by yc on 15-4-5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUserInfo : NSObject
@property (nonatomic, strong)NSDictionary *userInfoDict;
+ (instancetype)sharedUserInfo;
+ (void)loadDataWithBlock:(void(^)(NSDictionary *dict))block;
@end
