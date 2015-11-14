//
//  IWRetweetView.m
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWRetweetView.h"
#import "IWStatusFrame.h"
#import "IWUser.h"
#import "IWStatusCommon.h"
#import "IWPhotosView.h"
@interface IWRetweetView ()


// 昵称
@property (nonatomic, weak) UILabel *nameView;

// 内容
@property (nonatomic, weak) UILabel *textView;

// 转发的配图相册
@property (nonatomic, weak) IWPhotosView *photosView;

@end


@implementation IWRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildeView];
        
        self.image = [UIImage resizableImageWithName:@"timeline_retweet_background"];
        self.userInteractionEnabled = YES;
    }
    return self;
}
// 添加所有子控件
- (void)setUpAllChildeView
{
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
     // 52 83 86
//    nameView.textColor = IWColor(52, 83, 86);
    nameView.font = IWNameFont;
    _nameView = nameView;
    [self addSubview:nameView];
    
    // 内容
    UILabel *textView = [[UILabel alloc] init];
    textView.font = IWTextFont;
    textView.numberOfLines = 0;
    _textView = textView;
    [self addSubview:textView];
    
    // 配图的相册
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    _photosView = photosView;
    [self addSubview:photosView];
}


- (void)setSf:(IWStatusFrame *)sf
{
    _sf = sf;
    // 获取转发的微博
    IWStatus *status = sf.status.retweeted_status;
    
    // 设置所有子控件的内容和frame
    
    // 设置转发微博的昵称
    _nameView.text = [NSString stringWithFormat:@"@%@",status.user.name];
    // 设置转发微博昵称frame
    _nameView.frame = sf.retweetNameViewF;
    
    // 设置转发微博的内容
    _textView.text = status.text;
    _textView.frame = sf.retWeetTextViewF;
    
    // 设置转发微博配图尺寸
    _photosView.frame = sf.retWeetphotosViewF;
    _photosView.pic_urls = status.pic_urls;
    
}

@end
