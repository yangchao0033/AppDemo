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
#import "IWUserTool.h"
#import "IWUnReadResult.h"
#import "IWComposeViewController.h"



@interface IWTabBarController ()

@property (nonatomic, weak) IWTabBar *cusTomTabBar;
@property (nonatomic, weak) IWHomeViewController *home;
@property (nonatomic, weak) IWMessageViewController *message;
@property (nonatomic, weak) IWProfileViewController *profile;

// 当前的未读数
@property (nonatomic, assign) NSInteger curUnreadStatusCount;
// 总共的未读数
@property (nonatomic, assign) NSInteger lastTotalUnreadStatusCount;

@end

// 总共的未读数 =  总共的未读数 + 当前的未读数

/* 2 
    totalUnreadStatusCount = 0;
    curUnreadStatusCount = 2
    
    上啦刷新
 在上啦刷新的时候就马上记录主
  totalUnreadStatusCount = totalUnreadStatusCount(0) + curUnreadStatusCount(2);
    curUnreadStatusCount = 1
 
 只要上啦的时候,才需要记录主
 totalUnreadStatusCount = totalUnreadStatusCount(2) + curUnreadStatusCount(1) 3;
    curUnreadStatusCount = 0
 
 */

@implementation IWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 自定义tabBar
    IWTabBar *tabBar = [[IWTabBar alloc] initWithFrame:self.tabBar.bounds];
    __weak typeof(self) weakSelf = self;
    tabBar.tabBarblock = ^(NSInteger selectedIndex){
        
        // 判断是否点击首页,
        if (selectedIndex == 0 && selectedIndex == weakSelf.selectedIndex) { // 首页
            // 让首页
            [_home refresh];
        }
        
        // 点击的时候会调用
        weakSelf.selectedIndex = selectedIndex;// 0
    };
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    _cusTomTabBar = tabBar;
    // 加到系统自带的tabBar上面,就会自动隐藏功能
    [self.tabBar addSubview:tabBar];

    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    // 定义定时器,每隔一段时间做事情
    // 优先级低,在拖的时候,就不会触发这个定时器,想要拖动的时候,触发定时器
    // 加入主允许循环,并且设置模式为NSRunLoopCommonModes,就会让系统抽出时间来触发这个定时器
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 接收上啦刷新通知
    /**
     *  self谁监听通知
     *  selector 监听到通知的时候,调用这个方法
     *  name:通知的名称
     *  object:谁发出,一般传nil,意味着不管谁发出的都监听
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginMore) name:IWBeginMoreNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginNew) name:IWBeginNewNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBtnClick) name:IWAddBtnClickNote object:nil];
}
// 只要点击添加按钮就会调用
- (void)addBtnClick
{
    // modal发送微博控制器,包装成导航控制器
    IWComposeViewController *composeVc = [[IWComposeViewController alloc] init];
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 只要一上啦刷新就会调用
- (void)beginMore
{
    // 记录上一次总共未读数
    _lastTotalUnreadStatusCount = _lastTotalUnreadStatusCount + _curUnreadStatusCount;
}
- (void)beginNew
{
    _lastTotalUnreadStatusCount = 0;
}

// 加载未读数
- (void)loadUnreadCount
{
    
    // 获取用户的未读数,展示到tabBar上面
    [IWUserTool unReadCountDidSuccess:^(IWUnReadResult *unreadResult) {
        // 当前每次的未读数
        _curUnreadStatusCount = unreadResult.status;
       
        // 设置首页的微博未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",_lastTotalUnreadStatusCount + _curUnreadStatusCount];
        // 设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.messageCount];
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.follower];
        
        // 设置桌面提醒数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = unreadResult.totalCount;
        
    } failure:^(NSError *error) {
        
    }];

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
    _home = home;
    [self setUpOneChildViewController:home title:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    
    // 消息
    IWMessageViewController *message = [[IWMessageViewController alloc] init];
    _message = message;
    message.view.backgroundColor = [UIColor redColor];
    [self setUpOneChildViewController:message title:@"消息" image:[UIImage imageNamed:@"tabbar_message_center"] selImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
    
    // 广场
    IWDiscoverViewController *discover = [[IWDiscoverViewController alloc] init];
    
    [self setUpOneChildViewController:discover title:@"广场" image:[UIImage imageNamed:@"tabbar_discover"] selImage:[UIImage imageNamed:@"tabbar_discover_selected"]];

    
    // 我
    IWProfileViewController *profile = [[IWProfileViewController alloc] init];
    _profile = profile;
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
