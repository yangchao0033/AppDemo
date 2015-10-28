//
//  IWOAuthViewController.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  主要用来显示登录界面,并且获取accessToken

#import "IWOAuthViewController.h"
#import "AFNetworking.h"
#import "IWAccount.h"

#import "IWMainTool.h"

#import "MBProgressHUD+MJ.h"
#import "IWAccountTool.h"
#import "IWHttpTool.h"
#import "IWLoadFailedViewController.h"
#import <JDStatusBarNotification/JDStatusBarNotification.h>




@interface IWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation IWOAuthViewController

// 自定义控制器的view,让控制器的view是webView
// 节省一点点内存
- (void)loadView
{
    // 让控制器的view是webView
    self.view = [[UIWebView alloc] initWithFrame:IWScreenSizes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStart) name:YCLoginRefresh object:nil];
    // 加载登录界面
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    [self loadStart];
    
}
- (void)loadStart
{
    // 创建url == 完整url = 基本url + 参数
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",IWAppkey,IWRedirectUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:6.0];
    
    // 加载请求
    [(UIWebView *)self.view loadRequest:request];
}
// 开始加载请求的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [JDStatusBarNotification showWithStatus:@"正在加载..." dismissAfter:3.0 styleName:JDStatusBarStyleDark];
}

// 加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

// 加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"IWLoadFailedViewController" bundle:nil];
    IWLoadFailedViewController *failedVC = sb.instantiateInitialViewController;
    [self presentViewController:failedVC animated:YES completion:nil];
}


// 是否允许加载这个请求,加载一个网页之前调用这个方法
// 拦截requestToken
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获取请求标记
    NSString *urlStr = request.URL.absoluteString;

    // 搜索有木有code=
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 判断请求的url字符串有木有code=
    if (range.length) { // 有长度才有code=
        
        // 获取code
     NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        // 自定义方法,获取accessToken,封装功能,简化代码
        [self accessTokenWithCode:code];
        
        // 不需要加载回调界面
        return NO;
    }
    
    return YES;
}


// 换取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
    // 获取accessToken:发送post请求 -> AFN
    
    // 获取accessToken
    [IWAccountTool accessTokenWithCode:code success:^{
        
        // 获取主窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // 选择进入新特性还是首页
        // 判断有没有新特性,从而选择窗口的根控制器
        [IWMainTool chooseRootViewController:window];
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YCAppWillEnterFore object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YCLoginRefresh object:nil];
}


@end
