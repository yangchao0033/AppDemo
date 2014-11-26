//
//  IWNewFeatureCell.m
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWNewFeatureCell.h"
#import "IWTabBarController.h"

@interface IWNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation IWNewFeatureCell

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [button setTitle:@"分享给大家" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        
        // 计算尺寸
        [button sizeToFit];
        
        
        _shareButton = button;
        [self addSubview:button];
    }
    return _shareButton;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [button setTitle:@"开始微博" forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        // 计算尺寸
        [button sizeToFit];

        [self addSubview:button];

        _startButton = button;
    }
    return  _startButton;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV  = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        [self addSubview:imageV];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (void)setIndexPath:(NSIndexPath *)indexPath itemCount:(NSInteger)count
{
    // indexPath.item =  indexPath.row
    if (indexPath.item == count - 1) { // 就是最后一个cell
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

- (void)layoutSubviews
{
    // 一定要调用,设置系统自带的子控件位置,contentView
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    // 设置分享按钮的位置
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.75);
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.85);
}

// 点击分享按钮的时候调用
- (void)share:(UIButton *)button
{
    button.selected = !button.selected;
}
// 点击开始按钮的时候调用
- (void)start
{
    // modal -> 把控制器的view添加窗口
    // push -> 必须要有导航控制器
    
    // 切换窗口的跟控制
    IWKeywindow.rootViewController = [[IWTabBarController alloc] init];
    
    
}



@end
