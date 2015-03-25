//
//  IWFontSizeTool.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWFontSizeTool : NSObject

// 存储字体
+ (void)saveFontSize:(NSString *)fontSize;
// 获取字体
+ (NSString *)fontSize;


@end
