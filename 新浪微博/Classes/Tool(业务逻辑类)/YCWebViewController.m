//
//  YCWebViewController.m
//  新浪微博
//
//  Created by ChengLiQing on 15/4/25.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YCWebViewController.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <JDStatusBarNotification/JDStatusBarNotification.h>

@interface YCWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIButton *refresh;
@end

@implementation YCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.loadData) {
        self.loadData();
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [JDStatusBarNotification dismiss];
}

#pragma mark - 网页代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [JDStatusBarNotification showWithStatus:@"正在加载" styleName:JDStatusBarStyleDark];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:(UIActivityIndicatorViewStyleWhite)];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.refresh != nil) {
        NSLog(@"%@--移除", self.refresh);
        [self.refresh removeFromSuperview];
        self.refresh = nil;
        [self.view layoutIfNeeded];
        self.refresh.hidden = YES;
    }
    [JDStatusBarNotification dismissAnimated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [JDStatusBarNotification dismissAnimated:YES];
    [SVProgressHUD showErrorWithStatus:@"网络连接失败" maskType:(SVProgressHUDMaskTypeBlack)];
    // bug太多 pass
//    [self.view addSubview:self.refresh];
    // 使用警示框
    
    
}
// 返回主页面
- (IBAction)goBack:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)refresh:(id)sender
{
    [self.webView reload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)refresh
{
    if (_refresh == nil) {
        _refresh = [[UIButton alloc] init];
        NSLog(@"%@ --创建", self.refresh);
        CGFloat btnW = 80;
        CGFloat btnH = 30;
        CGFloat btnX = [UIScreen mainScreen].bounds.size.width *0.5 - btnW * 0.5;
        CGFloat btnY = [UIScreen mainScreen].bounds.size.height *0.5 - btnH * 0.5;
        _refresh.frame = CGRectMake(btnX, btnY, btnW, btnH);
        _refresh.backgroundColor = [UIColor greenColor];
        [_refresh setTitle:@"刷新页面" forState:(UIControlStateNormal)];
        [_refresh setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_refresh addTarget:self action:@selector(refresh:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _refresh;
}

@end
