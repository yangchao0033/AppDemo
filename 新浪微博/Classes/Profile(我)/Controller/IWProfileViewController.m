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
#import "YCWebViewController.h"
#import "IWAccountTool.h"
#include "IWAccount.h"
@interface IWProfileViewController ()

@end

@implementation IWProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 设置导航条
    [self setUpNav];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
// 点击设置按钮的时候调用
- (void)setting
{
    IWSettingViewController *settingVc = [[IWSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (void)setUpNav
{
    // 设置发送聊天按钮
    UIBarButtonItem *settting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = settting;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"%tu", indexPath.row);
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YCWebViewController" bundle:nil];
        YCWebViewController *vc = sb.instantiateInitialViewController;
        IWAccount *account = [IWAccountTool account];
        NSString *uid = account.uid;
        NSString *urlStr = [NSString stringWithFormat:@"http://m.weibo.cn/u/%@" ,uid];
        // http://m.weibo.cn/page/tpl?containerid=1005053266043817_-_WEIBO_SECOND_PROFILE_WEIBO&itemid=&title=全部微博
//        NSString *urlStr = [@"http://m.weibo.cn/page/tpl?containerid=1005053266043817_-_WEIBO_SECOND_PROFILE_WEIBO&itemid=&title=全部微博" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        /*
         UIModalTransitionStyleCoverVertical = 0,
         UIModalTransitionStyleFlipHorizontal,
         UIModalTransitionStyleCrossDissolve,
         UIModalTransitionStylePartialCurl
         */
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [vc.webView loadRequest:request];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
