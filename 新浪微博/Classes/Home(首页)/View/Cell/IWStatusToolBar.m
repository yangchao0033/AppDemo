//
//  IWStatusToolBar.m
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//



#import "IWStatusToolBar.h"
#import "IWStatus.h"
@interface IWStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divides;

@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *unlikeBtn;
@end

@implementation IWStatusToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divides{
    if (_divides == nil) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}
// 添加所有子控件
- (void)setUpAllChildView
{
    // 转发
  _retweetBtn =  [self setUpOneChildViewWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];

    // 评论
   _commentBtn = [self setUpOneChildViewWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    
    // 赞
   _unlikeBtn = [self setUpOneChildViewWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    
    
    // 添加所有的分割线
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divides addObject:divideV];
    }
    
}

// 添加一个按钮
- (UIButton *)setUpOneChildViewWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    // left->相对于之前title左边的位置添加10的间距,
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)setStatus:(IWStatus *)status
{
    _status = status;
    
    // count > 10000
    // 9999 9999
    // 12000 1.2W
    // 10020 1W
    // 10020 /10000.0 1.0W -> 1W @".0" @""
    
    // 设置转发按钮的标题
    [self setUpButton:_retweetBtn count:status.reposts_count originalTitle:@"转发"];

    // 设置评论按钮的标题
    [self setUpButton:_commentBtn count:status.comments_count originalTitle:@"评论"];
    
    // 设置赞按钮的标题
    [self setUpButton:_unlikeBtn count:status.attitudes_count originalTitle:@"赞"];
}

- (void)setUpButton:(UIButton *)button count:(int)count originalTitle:(NSString *)title
{

    if (count) { // 有木有转发数
        if (count > 10000) {
            CGFloat doubleRetweet = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",doubleRetweet];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
            
        }else{ // 小于10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        
    }
    
    [button setTitle:title forState:UIControlStateNormal];

}

// 计算子控件的尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算所有的按钮尺寸
    NSUInteger count = self.btns.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];

        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    // 计算所有分割线的尺寸
    for (int i = 0 ; i < self.divides.count; i++) {
        UIImageView *divideV = self.divides[i];
        UIButton *btn = self.btns[i + 1];
        divideV.x = btn.x;
    }
    
}

@end
