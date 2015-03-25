//
//  IWGroupItem.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  描述每一组长什么样子

#import <Foundation/Foundation.h>

@interface IWGroupItem : NSObject

/**
 *  一组有多少行cell(IWSettingItem)
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *headedTitle;

/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footerTitle;

@end
