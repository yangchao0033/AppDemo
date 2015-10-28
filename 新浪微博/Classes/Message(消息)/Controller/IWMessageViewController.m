//
//  IWMessageViewController.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWMessageViewController.h"
#import "AppInfo.h"
#import "AppInfoCell.h"
#import "NSString+Path.h"
#import "IWComposeViewController.h"
#import "IWNavigationController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YCTalkViewController.h"



@interface IWMessageViewController ()
///  应用程序列表
@property (nonatomic, strong) NSArray *appList;
///  全局队列，统一管理所有下载操作
@property (nonatomic, strong) NSOperationQueue *queue;
///  操作缓冲池
@property (nonatomic, strong) NSMutableDictionary *operationCache;
///  图像缓冲池
@property (nonatomic, strong) NSMutableDictionary *imageCache;
///  图像黑名单
@property (nonatomic, strong) NSMutableArray *blackList;
@property (nonatomic, weak) NSURL *iconUrl;
@end

@implementation IWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置发送聊天按钮
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStyleBordered target:self action:@selector(chatBegin:)];
    
    self.navigationItem.rightBarButtonItem = chat;
//    [self.tableView reloadData];
    
    __weak typeof(self) weakSelf = self;
    
    [AppInfo appListWithCompletion:^(NSMutableArray *appList) {
        weakSelf.appList = appList;
    }];
    
}
- (IBAction)chatBegin:(id)sender
{
    // modal发送微博控制器,包装成导航控制器
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"YCTalkViewController" bundle:nil];
    YCTalkViewController *vc = sb1.instantiateInitialViewController;
    vc.navigationItem.title = @"微博小助手";
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)blackList {
    if (_blackList == nil) {
        _blackList = [[NSMutableArray alloc] init];
    }
    return _blackList;
}

- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [[NSMutableDictionary alloc] init];
    }
    return _imageCache;
}

- (NSMutableDictionary *)operationCache {
    if (_operationCache == nil) {
        _operationCache = [[NSMutableDictionary alloc] init];
    }
    return _operationCache;
}

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)setAppList:(NSArray *)appList{
    _appList = appList;
    [self.tableView reloadData];
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.appList.count == 0) {
        return 1;
    } else {
        return self.appList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell2"];
    
    // 设置 Cell...
    AppInfo *app = self.appList[indexPath.row];
    if (app != nil) {
    cell.nameLabel.text = app.name;
    cell.downloadLabel.text = app.download;
    NSURL *iconUrl = [NSURL URLWithString:app.icon];
    UIImage *placeholder = [UIImage imageNamed:@"user_default"];
    [cell.iconImage sd_setImageWithURL:iconUrl placeholderImage:placeholder completed:nil];
    }
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
//    
//    // 设置 Cell...
//    MessageInfo *info = self.infoList[indexPath.row];
//    cell.nameLabel.text = info.name;
//    cell.desc.text = info.desc;
//    NSURL *iconUrl = [NSURL URLWithString:info.icon];
//    UIImage *placeholder = [UIImage imageNamed:@"user_default"];
//    [cell.iconImage sd_setImageWithURL:iconUrl placeholderImage:placeholder completed:nil];
//    return cell;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // 1. 清空缓冲池
    [self.imageCache removeAllObjects];
    [self.operationCache removeAllObjects];
    
    // 2. 停止所有下载操作
    [self.queue cancelAllOperations];
}

#pragma mark -- vc代理
- (void)YCTalkViewController:(YCTalkViewController *)vc talkReciverIcon:(UIImage *)icon
{
    
}
#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppInfo *app = self.appList[indexPath.row];
    YCTalkViewController *vc = nil;
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"YCTalkViewController" bundle:nil];
    vc = sb1.instantiateInitialViewController;
    if (app == nil) {
        vc.navigationItem.title = @"微博小助手";
        UIImage *placeholder = [UIImage imageNamed:@"icon_base@2x"];
        [vc cellDidSelectedAndComplitionWith:^(UIImageView *icon) {
            [icon sd_setImageWithURL:nil placeholderImage:placeholder];
        }];
    } else {
        NSURL *iconUrl = [NSURL URLWithString:app.icon];
        UIImage *placeholder = [UIImage imageNamed:@"user_default"];
        [vc cellDidSelectedAndComplitionWith:^(UIImageView *icon) {
            [icon sd_setImageWithURL:iconUrl placeholderImage:placeholder];
        }];
        vc.navigationItem.title = [self.appList[indexPath.row] name];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
