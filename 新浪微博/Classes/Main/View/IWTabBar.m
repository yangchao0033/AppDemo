//
//  IWTabBar.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"
@interface IWTabBar ()

@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@end

@implementation IWTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *add  =[UIButton buttonWithType:UIButtonTypeCustom];
    
        [add setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [add setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [add setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [add setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        // 自动算出控件最合适的尺寸
        [add sizeToFit];
        
        [self addSubview:add];
        
        _addButton = add;
        
    }
    return _addButton;
}

// 添加TabBarButton
- (void)addTabBarButton:(UITabBarItem *)item
{
    IWTabBarButton *button = [IWTabBarButton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
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
    
    int count = self.tabBarButtons.count + 1;
    CGFloat w = self.width / count;
    CGFloat h = self.bounds.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    int i = 0;
    for (UIView *tabBarButton in self.tabBarButtons) {
        
            if (i == 2) {
                i = 3;
            }
            x = i * w;
            tabBarButton.frame = CGRectMake(x, y, w, h);
            i++;
            
    }
}



#pragma mark - 设置加号按钮的frame
- (void)setUpAddButtonFrame
{
    self.addButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}
@end
