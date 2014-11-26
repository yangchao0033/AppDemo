//
//  IWMainTool.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWMainTool.h"

#import "IWTabBarController.h"
#import "IWNewFeatureViewController.h"

#define IWUserDefaults [NSUserDefaults standardUserDefaults]
#define IWVersionKey @"version"



@implementation IWMainTool
/**
 *  选中窗口的根控制器
 */
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 2.判断是否有新特性,用户的软件有新版本的时候
    // 获取Info.plist
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 获取当前用户的软件版本
    NSString *currentVersion = infoDict[@"CFBundleVersion"];
    // 获取上一次最新的版本
    NSString *lastVersion = [IWUserDefaults objectForKey:IWVersionKey];
    
    
    if (![currentVersion isEqualToString:lastVersion]) { // 1.0 , 1.1 不相等,意味有新版本
        // 进入新特性界面
        IWNewFeatureViewController *newFeatureVc = [[IWNewFeatureViewController alloc] init];
        
        window.rootViewController = newFeatureVc;
        
        // 存储最新版本号
        [IWUserDefaults setObject:currentVersion forKey:IWVersionKey];
        // 同步
        [IWUserDefaults synchronize];
        
    }else{
        // 进入主要界面
        // 3.创建tabBarController
        IWTabBarController *tabVc = [[IWTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabVc;
    }
}

@end
