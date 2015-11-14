//
//  HMTextAttachment.h
//  黑马5期微博
//
//  Created by teacher on 15/4/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMEmoticon.h"

@interface HMTextAttachment : NSTextAttachment

// 当前图片对应的名称
@property (nonatomic, copy) NSString *chs;

// 通过一个表情模型创建一个属性字符串
+ (NSAttributedString *)attributedStringWithEmoticon:(HMEmoticon *)emoticon fontHeight:(CGFloat)fontHeight;
@end
