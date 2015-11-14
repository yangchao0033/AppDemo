//
//  IWMainTool.h
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMainTool : NSObject
/**
 *  选择窗口的根控制器(需要进入新特性还是首页)
 *
 */
+ (void)chooseRootViewController:(UIWindow *)window;

@end
