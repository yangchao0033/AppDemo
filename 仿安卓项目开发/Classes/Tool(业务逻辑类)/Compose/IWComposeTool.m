//
//  IWComposeTool.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWComposeTool.h"
#import "IWHttpTool.h"
#import "IWComposeParam.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "IWUploadParam.h"

@implementation IWComposeTool

+ (void)composeWithStatus:(id)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    IWComposeParam *param = [IWComposeParam param];
    param.status = status;
    
    [IWHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
       
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithImage:(UIImage *)image status:(id)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWComposeParam *param = [IWComposeParam param];
    param.status = status;
    
    //上传的参数
    IWUploadParam *uploadParam = [[IWUploadParam alloc] init];
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.paramName = @"pic";
    uploadParam.fileName = @"image.png";
    uploadParam.mimeType = @"image/png";

    [IWHttpTool upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadParam success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
