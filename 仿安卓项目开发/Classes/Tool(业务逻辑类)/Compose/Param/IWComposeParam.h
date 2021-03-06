//
//  IWComposeParam.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseParam.h"
/*
 
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@interface IWComposeParam : IWBaseParam

@property (nonatomic, strong) id status;

@end
