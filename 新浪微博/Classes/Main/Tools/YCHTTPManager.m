//
//  YCHTTPManager.m
//  新浪微博
//
//  Created by yc on 15-4-18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import "MJExtension.h"
#import "YCHTTPManager.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "IWStatus.h"
@implementation YCHTTPManager

static YCHTTPManager *_instance;
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:HM_BASE_URL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return _instance;
}
- (void)sendStatusWithText:(NSString *)text success:(void (^)(IWStatus *))successBlock failure:(failureBlock)failureBlock
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:5];
    para[@"access_token"] = [IWAccountTool account].access_token;
    para[@"status"] = text;
    [self POST:HM_SEND_TEXT_STATUS parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (successBlock != nil) {
            // 先字典转模型
            IWStatus *status = [IWStatus objectWithKeyValues:responseObject];
            successBlock(status);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}
- (void)sendStatusWithText:(NSString *)text image:(UIImage *)image success:(void (^)(IWStatus *))successBlock failure:(failureBlock)failureBlock
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:5];
    para[@"access_token"] = [IWAccountTool account].access_token;
    para[@"status"] = text;
    // 图片不能通过字典做参数
//    UIImage *image = [UIImage imageNamed:@"001"];
    [self POST:HM_SEND_IMAGE_STATUS parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSData *date = UIImageJPEGRepresentation(image, 1);
//        [formData appendPartWithFileData:date name:@"pic" fileName:@"x2oo" mimeType:@"image/png"];
        NSData *date1 = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:date1 name:@"pic" fileName:@"3452" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (successBlock != nil) {
            IWStatus *status = [IWStatus objectWithKeyValues:responseObject];
            successBlock(status);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}
@end
