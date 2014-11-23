//
//  IWTabBarButton.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBarButton.h"
#define IWImageRadio 0.7

#import "IWBadgeView.h"

#define IWTabBarButtonMargin 5

@interface IWTabBarButton ()

@property (nonatomic, weak) IWBadgeView *badgeView;

@end

@implementation IWTabBarButton

- (IWBadgeView *)badgeView
{
    if (_badgeView == nil) {
        IWBadgeView *btn = [IWBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        _badgeView = btn;
        
    }
    return _badgeView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置图片的内容模式
        // contentMode -> UIImageView
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 设置文字对齐方式
        // textAlignment -> 有文字控件(UITexfField,UILabel,UITextView)
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 设置水平对齐方式(假如拿不到UILabel,就考虑contentHorizontalAlignment)
        // contentHorizontalAlignment -> UIControl
//        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
    }
    return self;
}


- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 设置控件的内容,小技巧-直接利用写好的方法,目的简化代码
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    /**
     *  Observer:观察者 --- > 按钮
     *  KeyPath:监听的属性 badgeValue
        options:监听新值改变 如果badgeValue有值的改变就会调用
     *  给item添加一个管擦着
     */
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}

// 只要item的badgeValue,image,selectedImage,title有新值改变就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.badgeView.badgeValue = _item.badgeValue;
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    [self setTitle:_item.title forState:UIControlStateNormal];


}

- (void)dealloc
{
    // 移除观察者
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"title"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置imageView的frame
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = self.height * IWImageRadio;
    CGFloat imageW = self.width;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 设置titleLabel的frame
    CGFloat titleY = imageH;
    CGFloat titleX = 0;
    CGFloat titleW = imageW;
    CGFloat titleH = self.height - imageH;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 设置badgeView的frame
    self.badgeView.x = self.width - self.badgeView.width - IWTabBarButtonMargin;
}

- (void)setHighlighted:(BOOL)highlighted{}


@end
