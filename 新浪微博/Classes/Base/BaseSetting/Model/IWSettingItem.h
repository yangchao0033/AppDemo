//
//  IWSettingItem.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  描述每个cell长什么样子

#import <Foundation/Foundation.h>
@class IWCheakItem;
@interface IWSettingItem : NSObject

/**
 *  描述imageView
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  描述textLabel
 */
@property (nonatomic, copy) NSString *title;
/**
 *  描述detailLabel
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 *  保存每一行需要做的事情
 */
@property (nonatomic, copy) void(^option)(IWCheakItem *item);

/**
 *  目标控制器的类名
 */
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;

@end
