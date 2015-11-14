//
//  IWUserInfo.m
//  新浪微博
//
//  Created by yc on 15-4-5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "IWUserInfo.h"
#import "AFNetworking.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "UIImageView+WebCache.h"

@implementation IWUserInfo

static IWUserInfo *sharedUserInfoManager = nil;
+ (instancetype)sharedUserInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserInfoManager = [[self alloc] init];
    });
    return sharedUserInfoManager;
}
//- (NSDictionary *)userInfoDict
//{
//    __weak typeof(self) weakSelf;
//    if (_userInfoDict == nil) {
//        [weakSelf loadDataWithBlock:^(NSDictionary *dict) {
//            _userInfoDict = dict;
//        }];
//    }
//    return _userInfoDict;
//}
- (void)setUserInfoDict:(NSDictionary *)userInfoDict
{
    if (_userInfoDict == nil) {
        NSLog(@"又加载数据了，小心封号");
        _userInfoDict = userInfoDict;
    }
}


+ (void)loadDataWithBlock:(void(^)(NSDictionary *dict))block
{
    // 加载网络数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    IWAccount *account = [IWAccountTool account];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?source=%@&access_token=%@&uid=%@",IWAppkey, account.access_token, account.uid];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 在主线程中跟新UI
        if (block) {
            block(responseObject);
        }
        NSLog(@"数据加载啦。。。。救命啊");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
