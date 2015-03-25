//
//  IWBaseParam.m
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseParam.h"
#import "IWAccountTool.h"

@implementation IWBaseParam
+ (instancetype)param
{
    IWBaseParam *param = [[self alloc] init];
    
    param.access_token = [IWAccountTool account].access_token;
    return param;
}
@end
