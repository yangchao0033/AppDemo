//
//  NSString+HMNSStringExt.m
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSString+HMNSStringExt.h"

@implementation NSString (HMNSStringExt)

- (CGSize)sizeOfTextWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return [NSString sizeWithText:self font:font maxSize:maxSize];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
