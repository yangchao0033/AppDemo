//
//  IWBaseSettingViewController.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseSettingViewController.h"
#import "IWGroupItem.h"
#import "IWSettingItem.h"
#import "IWSettingCell.h"

@implementation IWBaseSettingViewController

// 重写init,让我们控制器一出来就是group样式
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

// 返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}
// 返回一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    IWGroupItem *group = self.groups[section];
    return group.items.count;
}

// 返回每一行长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    IWSettingCell *cell = [IWSettingCell cellWithTableView:tableView];
    
    // 2.给cell传递模型
    IWGroupItem *group = self.groups[indexPath.section];
    IWSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    // 第一个Cell的y是35
    
    return cell;
}

// 返回头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    IWGroupItem *group = self.groups[section];
    return group.headedTitle;
}
// 返回尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    IWGroupItem *group = self.groups[section];
    return group.footerTitle;
}

// 点击某一行cell的时候做事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取消选中一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 取出点击的模型
    IWGroupItem *group = self.groups[indexPath.section];
    IWSettingItem *item = group.items[indexPath.row];
    
    if (item.option) { // 有事情就直接
        item.option(item);
        return;
    }
    
    
    // 跳转控制器
    if (item.destVcClass) { // 才需要跳转
        
//        // 获取目标控制器的类名
//        Class destVcClass =  NSClassFromString(item.destVc);
        UIViewController *vc = [[item.destVcClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
