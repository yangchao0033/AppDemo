//
//  IWTextView.m
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTextView.h"

@interface IWTextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation IWTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = self.font;
        [self addSubview:label];
        _placeHolderLabel = label;
        
    }
    return _placeHolderLabel;
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}
- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder  = [placeholder copy];
    self.placeHolderLabel.text = placeholder;
    
    
    // 计算尺寸
    [self.placeHolderLabel sizeToFit];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}

@end
