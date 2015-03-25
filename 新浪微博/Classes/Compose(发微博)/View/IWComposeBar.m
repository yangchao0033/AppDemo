//
//  IWComposeBar.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWComposeBar.h"

@implementation IWComposeBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    }
    return self;
}
// 添加所有子控件
- (void)setUpAllChildView
{
    // 添加5个按钮,每个按钮的图标
    // 相册
    [self setUpOneChildViewWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImg:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
    // 提及
    [self setUpOneChildViewWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImg:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    // 趋势
    [self setUpOneChildViewWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImg:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    // 表情
    [self setUpOneChildViewWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImg:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    // 键盘
    [self setUpOneChildViewWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImg:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
}

// 添加一个按钮
- (void)setUpOneChildViewWithImage:(UIImage *)image highImg:(UIImage *)highImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImg forState:UIControlStateHighlighted];
    button.tag = self.subviews.count;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

// 点击工具条的时候调用
- (void)btnClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(composeBar:didClickBtn:)]) {
        [_delegate composeBar:self didClickBtn:button.tag];
    }
}

// 计算所有子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
}

@end
