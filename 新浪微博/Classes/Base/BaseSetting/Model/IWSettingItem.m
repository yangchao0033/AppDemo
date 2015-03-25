//
//  IWSettingItem.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSettingItem.h"

@implementation IWSettingItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image
{
    IWSettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    item.image = image;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return  [self itemWithTitle:title subTitle:nil image:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    return [self itemWithTitle:title subTitle:nil image:image];
}

@end
