//
//  IWBaseParam.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数
 */
@property (nonatomic, strong) id access_token;

+ (instancetype)param;
@end
