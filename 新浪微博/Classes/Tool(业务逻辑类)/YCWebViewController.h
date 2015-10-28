//
//  YCWebViewController.h
//  新浪微博
//
//  Created by ChengLiQing on 15/4/25.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCWebView.h"


@interface YCWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet YCWebView *webView;
// 设置一个block存储加载信息
@property (nonatomic, copy)  void(^loadData)();
@end
