//
//  AppInfo.h
//  03-网络图片
//
//  Created by 刘凡 on 15/3/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

///  App 名称
@property (nonatomic, copy) NSString *name;
///  图标 URL
@property (nonatomic, copy) NSString *icon;
///  下载数量
@property (nonatomic, copy) NSString *download;

@property (nonatomic, copy)NSString *userID;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;
///  从 Plist 加载 AppInfo
//+ (NSArray *)appList;
+ (void)appListWithCompletion:(void(^)(NSMutableArray * appList))complection;

@end
