//
//  NSString+HMNSStringExt.h
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (HMNSStringExt)

// 对象方法
- (CGSize)sizeOfTextWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

// 类方法
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end
