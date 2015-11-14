//
//  IWPhotosView.m
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWPhotosView.h"
#import "IWPhoto.h"

#import "UIImageView+WebCache.h"
#import "IWStatusCommon.h"
#import "IWPhotoView.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define IWPhotoCount 9
@implementation IWPhotosView

- (void)show
{
    [self.subviews enumerateObjectsUsingBlock:^(IWPhotoView *obj, NSUInteger idx, BOOL *stop) {
        obj.hidden = NO;
        [UIView animateWithDuration:0.5 delay:0.0 options:(UIViewAnimationOptionTransitionCurlDown |UIViewAnimationOptionCurveEaseIn) animations:^{
            obj.alpha = 1;
        } completion:nil];
    }];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
//    self.backgroundColor = [UIColor redColor];
    // 删除原有的子空间
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加一个通知监听当减速停止后再显示
    // 添加所有的子控件,一开始就创建9个
    for (int i = 0; i < 9; i++) {
        IWPhotoView *photoView = [[IWPhotoView alloc] init];
//        photoView.hidden = YES;
//        photoView.backgroundColor = [UIColor blackColor];
        photoView.tag = i;
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [self addSubview:photoView];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    // 弹出图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = view.tag;
    NSMutableArray *arrM = [NSMutableArray array];
    for (IWPhoto *p in _pic_urls) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = (UIImageView *)view;
        photo.url = p.thumbnail_pic;
        [arrM addObject:photo];
    }
    
    browser.photos = arrM;
    
    [browser show];
}
// 一有新的cell出现的时候都会调用
// 注意:这里不能每次都创建新的,并且添加上去,因为这个方法会总是调用
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < pic_urls.count; i++) {
        IWPhotoView *photoView = self.subviews[i];
        IWPhoto *photo = pic_urls[i];
        photoView.photo = photo;
    }
    
  
    
}

// 计算所有子控件的尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int cols = _pic_urls.count == 4?2:3;

    int col = 0;
    int row = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    // 9 _pic_urls->6 0 1 2 3 4 5
    // 为什么不只设置需要显示图片的尺寸
    // cell 9张图片
    // 3 0 1 2 去设置位置 3 4 5 6 7 8
    for (int i = 0; i < IWPhotoCount; i++) {
        UIImageView *imageView = self.subviews[i];
        // 获取当前第几列
        col = i % cols;
        row = i / cols;
        x = col * (IWPhotoWH + IWPhotoMargin);
        y = row * (IWPhotoWH + IWPhotoMargin);
        imageView.frame = CGRectMake(x, y, IWPhotoWH, IWPhotoWH);
        // 判断如果i>=_pic_urls.count,就隐藏imageView
        if (i >= _pic_urls.count) { // 3  0 1 2->no 4 yes
            imageView.hidden = YES;
        }else{
            imageView.hidden = NO;
        }
        
    }
}

@end
