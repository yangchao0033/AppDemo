//
//  IWBadgeView.m
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBadgeView.h"
#define IWBadgeViewFont [UIFont systemFontOfSize:12]

@implementation IWBadgeView

// 加载xib完成的时候调用
- (void)awakeFromNib
{
    [self setUp];
}

// 初始化方法
- (void)setUp
{
    self.userInteractionEnabled = NO;
    self.titleLabel.font = IWBadgeViewFont;
    [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    
    [self sizeToFit];
}

// init内部就会initWithFrame,这个方法每个控件必须调用,前提条件必须代码创建
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 初始化操作
        [self setUp];

    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 判断文字是否有值或者是否等于0
    if ([_badgeValue isEqualToString:@"0"] || _badgeValue.length == 0){
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    
    // 设置文本属性(字体)
    NSMutableDictionary *textAtt = [NSMutableDictionary dictionary];
    textAtt[NSFontAttributeName] = IWBadgeViewFont;
    // 计算文字的尺寸
    CGSize textSize = [_badgeValue sizeWithAttributes:textAtt];
    
    if (textSize.width > self.width) {// 文字的尺寸大于按钮的尺寸
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{ // 文字的尺寸小于按钮的尺寸
        [self setImage:nil forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        // 设置按钮的标题
        [self setTitle:_badgeValue forState:UIControlStateNormal];

    }
    
}

@end
