//
//  IWTabBarController.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBarController.h"

#import "IWHomeViewController.h"
#import "IWMessageViewController.h"
#import "IWDiscoverViewController.h"
#import "IWProfileViewController.h"

#import "IWTabBar.h"

#import <objc/message.h>

@interface IWTabBarController ()

@property (nonatomic, weak) IWTabBar *cusTomTabBar;

@end

@implementation IWTabBarController

// 第一次使用这个类或者他的子类的时候调用
+ (void)initialize
{
    // 它只是所有item的标志
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *textAtt = [NSMutableDictionary dictionary];
    textAtt[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAtt forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 自定义tabBar
    IWTabBar *tabBar = [[IWTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    _cusTomTabBar = tabBar;
    [self.view addSubview:tabBar];
    
    // 把系统自带的干掉
    [self.tabBar removeFromSuperview];

    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    
//    int a = 10;
//    double b = (double)a;
//    [self setValue:tabBar forKey:@"tabBar"];

//    ((void(*)(id,SEL,id))objc_msgSend)(self,@selector(setTabBar:),tabBar);
//      (void(*)(id,SEL,id))objc_msgSend(self,@selector(setTabBar:),tabBar);

}



- (void)viewWillAppear:(BOOL)animated
{
    // 没有调用系统默认的做法
    [super viewWillAppear:animated];
    
}

#pragma mark -添加所有子控制器
- (void)setUpAllChildViewController
{
    // 首页
    IWHomeViewController *home = [[IWHomeViewController alloc] init];
    [self setUpOneChildViewController:home title:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    
    // 消息
    IWMessageViewController *message = [[IWMessageViewController alloc] init];
    [self setUpOneChildViewController:message title:@"消息" image:[UIImage imageNamed:@"tabbar_message_center"] selImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
    
    // 广场
    IWDiscoverViewController *discover = [[IWDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover title:@"广场" image:[UIImage imageNamed:@"tabbar_discover"] selImage:[UIImage imageNamed:@"tabbar_discover_selected"]];

    
    // 我
    IWProfileViewController *profile = [[IWProfileViewController alloc] init];
    [self setUpOneChildViewController:profile title:@"我" image:[UIImage imageNamed:@"tabbar_profile"] selImage:[UIImage imageNamed:@"tabbar_profile_selected"]];

}

#pragma mark -设置一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
   
    vc.tabBarItem.badgeValue = @"10";
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImage;
    [self addChildViewController:vc];
    
    [_cusTomTabBar addTabBarButton:vc.tabBarItem];
    
}


@end
