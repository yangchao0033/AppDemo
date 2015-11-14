//
//  NSString+Path.h
//  03-网络图片
//
//  Created by 刘凡 on 15/3/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

///  拼接文档目录
- (NSString *)appendDocumentPath;
///  拼接缓存目录
- (NSString *)appendCachePath;
///  拼接临时目录
- (NSString *)appendTempPath;

@end
