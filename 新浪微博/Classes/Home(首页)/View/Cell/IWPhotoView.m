//
//  IWPhotoView.m
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWPhotoView.h"
#import "UIImageView+WebCache.h"
#import "IWPhoto.h"

@interface IWPhotoView ()

@property (nonatomic, weak) UIImageView *gifV;

@end

@implementation IWPhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        // 设置内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的图片裁剪掉
        self.clipsToBounds = YES;
        
         // 添加所有的子控件
        UIImageView *gifV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        _gifV = gifV;
        [self addSubview:gifV];
    }
    return self;
}


- (void)setPhoto:(IWPhoto *)photo
{
    _photo = photo;
    // 加载图片
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    // 判断后缀
    // thumbnail_pic-> bmiddle
    if ([photo.thumbnail_pic.absoluteString hasSuffix:@".gif"]) {
        _gifV.hidden = NO;
    }else{
        _gifV.hidden = YES;
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _gifV.x = self.width - _gifV.width;
    _gifV.y = self.height - _gifV.height;
    
}
@end
