//
//  IWProfileViewController.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWProfileViewController.h"
#import "IWBaseSetting.h"
#import "IWProfileCell.h"
#import "IWSettingViewController.h"
@interface IWProfileViewController ()

@end

@implementation IWProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 设置导航条
    [self setUpNav];
    
    // 添加group0
    [self setUpGroup0];
    // 添加group1
    [self setUpGroup1];
    // 添加group2
    [self setUpGroup2];
    // 添加group3
    [self setUpGroup3];
    
}

- (void)setUpGroup0
{
    
    // 新的好友
    IWArrowItem *friend = [IWArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];

    IWGroupItem *group = [[IWGroupItem alloc] init];
 
    group.items = @[friend];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    
    // 我的相册
    IWArrowItem *friend = [IWArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    friend.subTitle = @"(12)";
    // 我的收藏
    IWArrowItem *collect = [IWArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    // 赞
    IWArrowItem *like = [IWArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(1)";
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    
    group.items = @[friend,collect,like];
    
    [self.groups addObject:group];
}

- (void)setUpGroup2
{
    
    // 微博支付
    IWArrowItem *pay = [IWArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    // 个性化
    IWArrowItem *vip = [IWArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源,皮肤,封面图";
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    
    group.items = @[pay,vip];
    
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    
    // 我的二维码
    IWArrowItem *card = [IWArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    // 草稿箱
    IWArrowItem *draft = [IWArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    
    group.items = @[card,draft];
    
    [self.groups addObject:group];
}

// 点击设置按钮的时候调用
- (void)setting
{
    IWSettingViewController *settingVc = [[IWSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
    IWLog(@"%s",__func__);
}

- (void)setUpNav
{
    // 设置发送聊天按钮
    UIBarButtonItem *settting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = settting;
}

// 返回每一行长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    IWProfileCell *cell = [IWProfileCell cellWithTableView:tableView];
    
    // 2.给cell传递模型
    IWGroupItem *group = self.groups[indexPath.section];
    IWSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}



@end
