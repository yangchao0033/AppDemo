//
//  HMTextAttachment.m
//  黑马5期微博
//
//  Created by teacher on 15/4/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMTextAttachment.h"

@implementation HMTextAttachment


+ (NSAttributedString *)attributedStringWithEmoticon:(HMEmoticon *)emoticon fontHeight:(CGFloat)fontHeight
{
    // 1.创建附件
    HMTextAttachment *attachment = [[HMTextAttachment alloc] init];
    attachment.image = [[UIImage alloc] initWithContentsOfFile:emoticon.imagePath];
    attachment.chs = emoticon.chs;
    attachment.bounds = CGRectMake(0, -4, fontHeight, fontHeight);
    
    // 2.根据附件生产属性字符串
    return [NSAttributedString attributedStringWithAttachment:attachment];
}
@end
