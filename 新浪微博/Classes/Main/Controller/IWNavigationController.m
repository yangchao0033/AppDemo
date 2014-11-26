//
//  IWNavigationController.m
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWNavigationController.h"
#import "IWTabBarController.h"
#import "IWTabBar.h"

@interface IWNavigationController()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

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

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
}

// 将要显示viewController这个控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只要覆盖了导航条系统自带的左边按钮,这个代理就会做些事情
    // 实现滑动返回功能
    // 直接删除,系统的某些相当于不会调用
    if (viewController == self.viewControllers[0]) { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // self - 导航控制器
    if (self.viewControllers.count) { // 不是根控制器
        
        // 设置One控制器的导航条
        // 设置左边的按钮
        UIBarButtonItem *popPre = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popPre)];
        
        // 设置导航条的左边按钮
        viewController.navigationItem.leftBarButtonItem = popPre;
        
        // 设置右边的按钮
        UIBarButtonItem *popRoot = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popRoot)];
        
        // 设置导航条的按钮
        viewController.navigationItem.rightBarButtonItem = popRoot;
        
    }

    
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

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    IWTabBarController *tabVc =  (IWTabBarController *)IWKeywindow.rootViewController;
    
    // 调用系统的方法popRoot
   NSArray *arr =  [super popToRootViewControllerAnimated:animated];
    
    
    // 删除self.tabBar中的子控件除了自定义tabBar
    for (UIView *childView in tabVc.tabBar.subviews) {
        if (![childView isKindOfClass:[IWTabBar class]]) { // 不是自己的tabBar
            
            [childView removeFromSuperview];
        }
        
    }

    
    return arr;
}

@end
