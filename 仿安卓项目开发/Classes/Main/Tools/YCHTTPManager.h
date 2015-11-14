//
//  YCHTTPManager.h
//  新浪微博
//
//  Created by yc on 15-4-18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "AFHTTPSessionManager.h"
//#import "AFHTTPSessionManager.h"
#import "IWAccount.h"
#import "IWStatus.h"
#import "IWUnReadResult.h"

// api根路径
#define HM_BASE_URL [NSURL URLWithString:@"https://api.weibo.com/"]
// 用户信息
#define HM_USER_INFO @"2/users/show.json"
// 授权相关
#define HM_CLIENT_ID @"324956125"
#define HM_CLIENT_SECRET @"c45f8e4409348f3843bd7158df7b77cb"
#define HM_REDIRECT_URL @"http://ios.itcast.cn"
#define HM_ACCESSTOKEN_URL @"oauth2/access_token"
// 首页微博
#define HM_HOME_STATUS @"2/statuses/home_timeline.json"
// 未读信息
#define HM_UN_READ_COUNT @"2/remind/unread_count.json"
// 登陆界面
#define HM_REQUEST_TOKEN_BEASE_URL @"https://api.weibo.com/oauth2/authorize"
// 发送文本微博
#define HM_SEND_TEXT_STATUS @"2/statuses/update.json"
// 发送图片微博
#define HM_SEND_IMAGE_STATUS @"2/statuses/upload.json"
typedef void(^successBlock)(IWUnReadResult *countModel);
typedef void(^failureBlock)(NSError *error);

@interface YCHTTPManager : AFHTTPSessionManager
+ (instancetype)sharedManager;
- (void)sendStatusWithText:(NSString *)text success:(void(^)(IWStatus *status))successBlock failure:(failureBlock)failureBlock;
- (void)sendStatusWithText:(NSString *)text image:(UIImage *)image success:(void (^)(IWStatus *))successBlock failure:(failureBlock)failureBlock;
@end
