//
//  IWStatusParm.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseParam.h"

/*
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@interface IWStatusParam : IWBaseParam


/**
 *  若指定此参数，则返回ID比since_id大的微博
 */
@property (nonatomic, strong) id since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博
 */
@property (nonatomic, strong) id max_id;

@end
