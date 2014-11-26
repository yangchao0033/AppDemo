//
//  IWTitleButton.m
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTitleButton.h"

@interface IWTitleButton ()

@property (nonatomic, strong) UIImage *curImage;

@end

@implementation IWTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        // 拉伸背景图片
        UIImage *image = [UIImage resizableImageWithName:@"navigationbar_filter_background_highlighted"];
        
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        
    }
    return self;
}


// 只要自己的frame改变就会调用,添加了子控件的时候也会调用,前提条件在viewDidLoad方法过后添加子控件才会调用
- (void)layoutSubviews
{
    [super layoutSubviews];

    if (_curImage) {
        
        self.titleLabel.x = self.imageView.x;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    }
    
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    _curImage = image;
    // 设置UIImageView的图片,不会马上设置
    [super setImage:image forState:state];
    [self sizeToFit];
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}



@end
