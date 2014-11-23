//
//  AppDelegate.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "AppDelegate.h"
#import "IWTabBarController.h"

#define IWUserDefaults [NSUserDefaults standardUserDefaults]
#define IWVersionKey @"version"

#define IWScreenSize [UIScreen mainScreen].bounds

@interface AppDelegate ()

@end

@implementation AppDelegate

// 程序启动完成的时候调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:IWScreenSize];
    
    
    // 2.判断是否有新特性,用户的软件有新版本的时候
    // 获取Info.plist
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 获取当前用户的软件版本 1.1
    NSString *currentVersion = infoDict[@"CFBundleVersion"];
    // 获取上一次最新的版本
    NSString *lastVersion = [IWUserDefaults objectForKey:IWVersionKey];
    
//    if (![currentVersion isEqualToString:lastVersion]) { // 1.0 , 1.1 不相等,意味有新版本
//        // 进入新特性界面
//        
//        // 存储最新版本号1.0
//        [IWUserDefaults setObject:currentVersion forKey:IWVersionKey];
//        // 同步
//        [IWUserDefaults synchronize];
//        
//    }else{
//        // 进入主要界面
//    }
    
    
    
    // 3.创建tabBarController
    IWTabBarController *tabVc = [[IWTabBarController alloc] init];
    
    // 设置窗口的根控制器
    self.window.rootViewController = tabVc;
    
    // 3.显示窗口并且成为主窗口
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
