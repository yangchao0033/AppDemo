//
//  IWUserParam.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseParam.h"
/*
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	false	int64	需要查询的用户ID。
 */
@interface IWUserParam : IWBaseParam

/**
 *  需要查询的用户ID
 */
@property (nonatomic, strong) id uid;

@end
