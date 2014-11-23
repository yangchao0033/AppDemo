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

#import "IWNavigationController.h"



@interface IWTabBarController ()

@property (nonatomic, weak) IWTabBar *cusTomTabBar;

@end

@implementation IWTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 自定义tabBar
    IWTabBar *tabBar = [[IWTabBar alloc] initWithFrame:self.tabBar.bounds];
    __weak typeof(self) weakSelf = self;
    tabBar.tabBarblock = ^(NSInteger selectedIndex){
        weakSelf.selectedIndex = selectedIndex;
    };
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    _cusTomTabBar = tabBar;
    // 加到系统自带的tabBar上面,就会自动隐藏功能
    [self.tabBar addSubview:tabBar];

    // 添加所有子控制器
    [self setUpAllChildViewController];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    // 调用系统默认的做法:添加UITabBarButton
    [super viewWillAppear:animated];

    // 删除self.tabBar中的子控件除了自定义tabBar
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[IWTabBar class]]) { // 不是自己的tabBar
            
            [childView removeFromSuperview];
        }
        
    }
    
    
}

#pragma mark -添加所有子控制器
- (void)setUpAllChildViewController
{
    // 首页
    IWHomeViewController *home = [[IWHomeViewController alloc] init];
    [self setUpOneChildViewController:home title:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    
    // 消息
    IWMessageViewController *message = [[IWMessageViewController alloc] init];
    message.view.backgroundColor = [UIColor redColor];
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
    // vc.title =  vc.tabBarItem.title and     vc.navigationItem.title
    vc.title = title;

    vc.tabBarItem.image = image;
   
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImage;
    // 使用自己的导航控制器包装
    UINavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:vc];
    

    [self addChildViewController:nav];
    
    [_cusTomTabBar addTabBarButton:vc.tabBarItem];

}


@end
