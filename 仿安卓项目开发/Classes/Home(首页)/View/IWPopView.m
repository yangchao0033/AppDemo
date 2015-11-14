//
//  IWPopView.m
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWPopView.h"

@implementation IWPopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage resizableImageWithName:@"popover_background"];
        self.userInteractionEnabled = YES;
    }
    return self;
}

static UIView *cover;

+ (instancetype)showInRect:(CGRect)rect
{
    IWPopView *popView = [[IWPopView alloc] init];
    
    popView.frame = rect;
    
    [IWKeywindow addSubview:popView];
    return popView;
}

+ (void)dismiss
{
    // self -> IWPopView
    for (UIView *popView in IWKeywindow.subviews) {
        if ([popView isKindOfClass:self]) {
            [popView removeFromSuperview];
        }
    }
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    _contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 9;
    CGFloat w = self.width;
    CGFloat h = self.height - 9;
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

@end
