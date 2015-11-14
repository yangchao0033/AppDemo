//
//  IWOriginalView.m
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWOriginalView.h"
#import "IWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "IWUser.h"

#import "IWStatusCommon.h"
#import "IWPhotosView.h"

@interface IWOriginalView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;

// 昵称
@property (nonatomic, weak) UILabel *nameView;
// 会员图标
@property (nonatomic, weak) UIImageView *vipView;
// 时间
@property (nonatomic, weak) UILabel *timeView ;
// 来源
@property (nonatomic, weak) UILabel *sourceView;
// 内容
@property (nonatomic, weak) UILabel *textView;

// 配图的相册
@property (nonatomic, weak) IWPhotosView *photosView;

@end

@implementation IWOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildeView];

        self.image = [UIImage resizableImageWithName:@"timeline_card_top_background"];
        self.userInteractionEnabled = YES;
    }
    return self;
}
// 添加所有子控件
- (void)setUpAllChildeView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    _iconView = iconView;
    [self addSubview:iconView];
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = IWNameFont;
    _nameView = nameView;
    [self addSubview:nameView];
    
    // 会员图片
    UIImageView *vipView = [[UIImageView alloc] init];
    _vipView = vipView;
    [self addSubview:vipView];
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.textColor = [UIColor orangeColor];
    timeView.font = IWTimeFont;
    _timeView = timeView;
    [self addSubview:timeView];
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = IWSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
    _sourceView = sourceView;
    [self addSubview:sourceView];
    
    // 内容
    UILabel *textView = [[UILabel alloc] init];
   
    textView.numberOfLines = 0;
    textView.font = IWTextFont;
    _textView = textView;
    [self addSubview:textView];
    
    // 配图的相册
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    _photosView = photosView;
    [self addSubview:photosView];
}

// 获取到VM就会调用
- (void)setSf:(IWStatusFrame *)sf
{
    _sf = sf;
    
    IWStatus *status = sf.status;
    
    // 头像frame
    _iconView.frame = sf.iconViewF;
    
    // 设置头像的内容
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    
    // 昵称
    _nameView.frame = sf.nameViewF;
    _nameView.text = status.user.name;
    
    // 会员图标
    if (status.user.vip) { // 会员
        // frame
        _vipView.frame = sf.vipViewF;
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
        // 设置会员的内容
        _vipView.image = [UIImage imageNamed:imageName];
        _vipView.hidden = NO;
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
        // 有可能下一次不是会员
        _vipView.hidden = YES;
    }
    
    // 时间
    CGFloat timeX = sf.nameViewF.origin.x;
    CGFloat timeY = CGRectGetMaxY(sf.nameViewF);
    // 根据文字内容算出尺寸,font:根据这样的字体算
    CGSize timeSize = [status.created_at sizeWithFont:IWTimeFont];
    // 设置创建时间的frame
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + IWCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:IWSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 时间
    // 设置时间
    _timeView.text = status.created_at;
//    _timeView.frame = sf.timeViewF;
    
    // 来源
    _sourceView.text = status.source;
//    _sourceView.frame = sf.soureceViewF;
    
    // 内容
    _textView.text = status.text;
    _textView.frame = sf.textViewF;
    
    // 配图
    // 配图尺寸
    _photosView.frame = sf.photosViewF;
    
    // 配图内容
    _photosView.pic_urls = status.pic_urls;
    
    
}

@end
