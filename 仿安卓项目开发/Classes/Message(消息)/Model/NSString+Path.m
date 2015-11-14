//
//  NSString+Path.m
//  03-网络图片
//
//  Created by 刘凡 on 15/3/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendDocumentPath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendCachePath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)appendTempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
