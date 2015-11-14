//
//  HMMessageFrame.m
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMMessageFrame.h"
#import <UIKit/UIKit.h>
#import "HMMessage.h"
#import "NSString+HMNSStringExt.h"



@implementation HMMessageFrame


- (void)setMessage:(HMMessage *)message
{

    _message = message;
    
    // 计算frame坐标
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 控件与控件之间的间距
    CGFloat margin = 10;
    
    
    
    // 发送时间
    CGFloat timeW = screenW;
    CGFloat timeH = 25;
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    // "时间label"需要被隐藏, 那么此时就不计算Frame了。不计算默认就是0.
    if (!self.hideTime) {
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    
    // 头像
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
    if (self.hideTime) {
        iconY = _textFrame.origin.y + margin;
    }
    CGFloat iconX = screenW - margin - iconW; // 假设默认计算的是自己的头像坐标
    if (message.type == HMMessageTypeOther) {
        iconX = margin;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
          
    
    // 计算消息正文的坐标
    CGSize textSize = [message.text sizeOfTextWithFont:HMTextFont maxSize:CGSizeMake(240, MAXFLOAT)];
    CGFloat textW = textSize.width + 40;
    CGFloat textH = textSize.height + 30;
    CGFloat textY = CGRectGetMaxY(_timeFrame) + margin;
    CGFloat textX = screenW - margin - iconW - margin - textW; //默认计算的是自己的正文的值
    if (message.type == HMMessageTypeOther) {
        textX = margin + iconW + margin;
    }
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    
    // 计算行高
    CGFloat maxY = MAX(CGRectGetMaxY(_iconFrame), CGRectGetMaxY(_textFrame));
    _cellHeight = maxY + margin;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
@end
