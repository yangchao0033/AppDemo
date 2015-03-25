//
//  IWSettingViewController.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSettingViewController.h"
#import "IWBaseSetting.h"
#import "IWCommonSettingViewController.h"

@implementation IWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 添加group0
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加group3
    [self setUpGroup3];
    
}

- (void)setUpGroup0
{
    
    // 账号管理
    IWBadgeItem *account = [IWBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"10";
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    
    group.items = @[account];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    
    // 提醒和通知
    IWArrowItem *notice = [IWArrowItem itemWithTitle:@"我的相册" ];
    // 通用设置
    IWArrowItem *setting = [IWArrowItem itemWithTitle:@"通用设置" ];
    // 设置跳转控制器的类名
    setting.destVcClass = [IWCommonSettingViewController class];
    
    
    // 隐私与安全
    IWArrowItem *secure = [IWArrowItem itemWithTitle:@"隐私与安全" ];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[notice,setting,secure];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 意见反馈
    IWArrowItem *suggest = [IWArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    IWArrowItem *about = [IWArrowItem itemWithTitle:@"关于微博"];
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[suggest,about];
    [self.groups addObject:group];
}

- (void)setUpGroup3
{
    IWLabelItem *logout = [[IWLabelItem alloc] init];
    logout.text = @"退出当前账号";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    
    group.items = @[logout];
    
    [self.groups addObject:group];
}

@end
