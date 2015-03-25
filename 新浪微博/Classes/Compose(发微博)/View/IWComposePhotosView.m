//
//  IWComposePhotosView.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWComposePhotosView.h"

@implementation IWComposePhotosView
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (void)addImage:(UIImage *)image
{
   UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    
    [self addSubview:imageV];
    
    // 添加到数组
    [self.images addObject:image];
}

// 只要添加一个控件也会,前提条件在viewDidLoad方法只会添加才行
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat col = 0;
    CGFloat row = 0;
    CGFloat margin = 10;
    int cols = 3;
    // 算出每一个图片的宽度(总共的宽度) (self.width - (cols - 1) * margin) / cols
    CGFloat wh = (self.width - 2 * margin) / cols;
    for (int i = 0; i < count; i++) {
        UIImageView *imgV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imgV.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
