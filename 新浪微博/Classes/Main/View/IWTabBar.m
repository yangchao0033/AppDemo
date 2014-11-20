//
//  IWTabBar.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBar.h"

@interface IWTabBar ()

@property (nonatomic, weak) UIButton *addButton;

@end

@implementation IWTabBar

- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *add  =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [add setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [add setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [add setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [add setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [self addSubview:add];
        
        _addButton = add;
        
    }
    return _addButton;
}

// 调整内部子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有tabBarButton的frame
    [self setUpAllTabBarButtonFrame];
    
    // 设置加号按钮的frame
    [self setUpAddButtonFrame];

    
}
#pragma mark - 设置所有tabBarButton的frame
- (void)setUpAllTabBarButtonFrame
{
    int count = self.items.count + 1;
    CGFloat w = self.bounds.size.width / count;
    CGFloat h = self.bounds.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) { // tabbarButton
            if (i == 2) {
                i = 3;
            }
            
            x = i * w;
            tabBarButton.frame = CGRectMake(x, y, w, h);
            i++;
        }
    }
}

#pragma mark - 设置加号按钮的frame
- (void)setUpAddButtonFrame
{
    CGSize btnSize = self.addButton.currentBackgroundImage.size;
    self.addButton.bounds = CGRectMake(0, 0, btnSize.width, btnSize.height);
    
    self.addButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}
@end
