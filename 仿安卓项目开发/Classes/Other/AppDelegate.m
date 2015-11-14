//
//  AppDelegate.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "AppDelegate.h"
#import "IWOAuthViewController.h"
#import "IWMainTool.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate

// 程序启动完成的时候调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册提醒通知
    if (iOS8) { // ios8才需要注册通知
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [application registerUserNotificationSettings:setting];
    }
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:IWScreenSizes];
    // 2.获取accessToken
    IWAccount *account = [IWAccountTool account];
    NSString *accessToken = account.access_token;
    if (account.access_token) { // 已经获取成功
        // 判断有没有新特性,从而选择窗口的根控制器
    [IWMainTool chooseRootViewController:self.window];
        NSLog(@"accessToken=%@, uid=%@, source=%@", account.access_token, account.uid, IWAppkey);
    }
    else{ // 还没有获取过授权
        // 进入授权
        IWOAuthViewController *oauth = [[IWOAuthViewController alloc] init];
        self.window.rootViewController = oauth;
    }
    // 3.显示窗口并且成为主窗口
    [self.window makeKeyAndVisible];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

// 当我们的应用程序接收到内存警告的时候就会调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1.停止所有图片下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2.删除所有的内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
    
}


// test code test code test code  test code test code
// 1 2 3 4 5 6 7 8 9 1 2 3
// test code

// 进入后台的时候调用,ios7中做后台运行处理,就再此方法中做
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启后台任务,这个时间是不确定,由系统决定.如果后台任务被关掉,程序就不能后台运行
   UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
       // 程序关闭的时候,就会调用
        // 主动关闭后台任务
       [application endBackgroundTask:taskID];
       
    }];
    
    
    
    if (!iOS8) {
        // 播放,新浪微博给一个没有声音的Mp3,目的是需要告诉苹果,我在播放东西,并不需要让用户听到.
        // 创建本地播放对象
        // url:要播放文件的url
        // 获取url,从bundle里面获取
        // 获取本地播放文件的url
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _player = player;
        
        // -1无限播放
        player.numberOfLoops = -1;
        
        [player prepareToPlay];
        
        [player play];
 
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] postNotificationName:YCAppWillEnterFore object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
