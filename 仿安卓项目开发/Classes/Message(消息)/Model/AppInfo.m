//
//  AppInfo.m
//  03-网络图片
//
//  Created by 刘凡 on 15/3/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AppInfo.h"
#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWAccountTool.h"

@interface AppInfo ()

@end

@implementation AppInfo

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%p>\nicon=%@", self, self.icon];
}
+ (instancetype)appInfoWithDict:(NSDictionary *)dict {
    AppInfo *obj = [[self alloc] init];
    obj.name = dict[@"screen_name"];
    obj.icon = dict[@"avatar_large"];
    obj.download = dict[@"location"];
    obj.userID = dict[@"idstr"];
    return obj;
}

- (NSString *)name{
    if (_name == nil) {
        return @"姓名";
    }else {
        return _name;
    }
}

+ (void)appListWithCompletion:(void(^)(NSMutableArray * appList))complection {
    IWAccount *account = [IWAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/friendships/friends.json?access_token=%@&uid=%@", account.access_token, account.uid];
    NSString *testUrl = @"http://127.0.0.1/好友列表.json";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    __block NSMutableArray *list;
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array = responseObject[[responseObject keyEnumerator].nextObject];
        NSMutableArray *list = [NSMutableArray arrayWithCapacity:array.count];
        [array enumerateObjectsUsingBlock:^(id dict, NSUInteger idx, BOOL *stop) {
            [list addObject:[self appInfoWithDict:dict]];
        }];
        if (complection)
        complection(list);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
