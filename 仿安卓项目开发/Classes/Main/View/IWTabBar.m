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
@property (nonatomic, weak) UIButton *selectedButton;
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
        
        [add addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        // 自动算出控件最合适的尺寸
        [add sizeToFit];
        [self addSubview:add];
        _addButton = add;
    }
    return _addButton;
}
// 点击添加按钮的时候调用
- (void)addBtnClick
{
    // 通知
    [[NSNotificationCenter defaultCenter] postNotificationName:IWAddBtnClickNote object:nil];
}

// 添加TabBarButton
- (void)addTabBarButton:(UITabBarItem *)item
{
    IWTabBarButton *button = [IWTabBarButton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    
    button.tag = self.subviews.count;
    
    // 监听按钮
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    if (button.tag == 0) { // 默认选中第一个按钮
        [self btnClick:button];
    }
    
    
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
}

// 点击按钮的时候调用
- (void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 让block做事情
    if (_tabBarblock) {
        _tabBarblock(button.tag);
    }
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
    int count = (int)self.tabBarButtons.count + 1;
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
