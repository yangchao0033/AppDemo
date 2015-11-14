//
//  YCTextView.h
//  新浪微博
//
//  Created by yc on 15-4-17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMEmoticon.h"

@interface YCTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
// 设置填写表情
// 设置表情
- (void)setEmoticonStr:(HMEmoticon *)emoticon;
// 返回需要发送的文本
// 里面包含普通文本+emoji+自定义表情
- (NSString *)fullTextStr;
@end
