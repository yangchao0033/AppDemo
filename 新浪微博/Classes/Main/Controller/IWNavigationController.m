//
//  IWNavigationController.m
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWNavigationController.h"

@implementation IWNavigationController

// 第一次使用本类或者子类的时候调用
+ (void)initialize
{
    // 获取所有的UIBarButtonItem
    UIBarButtonItem *barItem =  [UIBarButtonItem appearance];
    
    // 创建文本的属性字典
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 给模型设置富文本属性(可以设置字符串的一些颜色,字体大小)
    [barItem setTitleTextAttributes:textDict forState:UIControlStateNormal];

}

#warning TODO:导航功能未解决

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 设置One控制器的导航条
    // 设置左边的按钮
    UIBarButtonItem *popPre = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popPre)];
    
    // 设置导航条的按钮
    viewController.navigationItem.leftBarButtonItem = popPre;
    
    // 设置右边的按钮
    UIBarButtonItem *popRoot = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popRoot)];
    
    // 设置导航条的按钮
    viewController.navigationItem.rightBarButtonItem = popRoot;

    
    // 调用系统默认做法,因为只有系统才知道怎么做push
    [super pushViewController:viewController animated:animated];
}


- (void)popPre
{
    // 回到上一个控制器
    [self popViewControllerAnimated:YES];
}
- (void)popRoot
{
    // 回到根控制器控制器
    [self popToRootViewControllerAnimated:YES];
}

@end
