//
//  IWStatusFrame.m
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatusFrame.h"
#import "IWUser.h"

#import "IWStatusCommon.h"
@implementation IWStatusFrame

// 只要传递微博模型就算出所有子控件的尺寸
- (void)setStatus:(IWStatus *)status
{
    _status = status;
    
    // 原创微博frame
    [self setUpOriginalFrame];
    
    // 工具条
    CGFloat toolY = CGRectGetMaxY(_originalViewF);
    
    if (_status.retweeted_status) { // 判断有木有转发微博
        
        // 1. _retweetViewF -> _retWeetTextViewF
        // 转发微博
        [self setUpRetweetFrame];
        
        
        // 先要算出转发微博的frame,才赋值
        toolY = CGRectGetMaxY(_retweetViewF);
    }
    
    _toolBarF = CGRectMake(0, toolY, IWScreenWidth, 35);
    
    // cell高度
    _cellH = CGRectGetMaxY(_toolBarF);
    
    
}
// 原创微博frame
- (void)setUpOriginalFrame
{
    // 头像
    CGFloat iconXY = IWCellMargin;
    CGFloat iconWH = 35;
    _iconViewF = CGRectMake(iconXY, iconXY, iconWH, iconWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + IWCellMargin;
    CGFloat nameY = iconXY;
    CGSize nameSize = [_status.user.name sizeWithFont:IWNameFont];
    // 强转结构体,因为不知道这样的是哪个结构体
    _nameViewF = (CGRect){{nameX,nameY},nameSize};
    
    // 会员图标
    if (_status.user.vip) { // 会员
        CGFloat vipX = CGRectGetMaxX(_nameViewF) + IWCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _vipViewF = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    

    
    // 内容
    CGFloat textX = IWCellMargin;
    CGFloat textY = CGRectGetMaxY(_iconViewF) + IWCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = IWTextFont;
    // Size:限制尺寸,限制文字最高多少最宽多少
    CGRect textR = [_status.text boundingRectWithSize:CGSizeMake(IWScreenWidth - 2 * IWCellMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil];
    _textViewF = (CGRect){{textX,textY},textR.size};
    
    CGFloat originH = CGRectGetMaxY(_textViewF) + IWCellMargin;
    if (_status.pic_urls.count) { // 有配图
        // 配图的frame
        CGFloat photoX = textX;
        CGFloat photoY = CGRectGetMaxY(_textViewF) + IWCellMargin;
        CGSize photoSize = [self photosSizeWithCount:_status.pic_urls.count ];
        _photosViewF = (CGRect){{photoX,photoY},photoSize};
        // 最大的配图加上一段间距
        originH =  CGRectGetMaxY(_photosViewF) + IWCellMargin;
    }
    
    
    // 整个原创微博的frame
    CGFloat originY = IWCellMargin;
    _originalViewF = CGRectMake(0, originY, IWScreenWidth, originH);
}

// 计算相册的尺寸
- (CGSize)photosSizeWithCount:(NSUInteger)count
{
    // 9 cols=3 rows = 3
    // 5 cols=3 rows =2
    // 4 cols=2 rows 2
    
    // 获取总列数
    NSInteger cols = count == 4?2:3;
    // 获取总行数
    NSInteger rows = (count - 1) / cols + 1;

    CGFloat photosW = cols * IWPhotoWH + (cols - 1) * IWPhotoMargin;
    CGFloat photosH = rows * IWPhotoWH + (rows - 1) * IWPhotoMargin;
 
    return CGSizeMake(photosW, photosH);
}

// 转发微博
- (void)setUpRetweetFrame
{
    // 昵称
    CGFloat nameX = IWCellMargin;
    CGFloat nameY = IWCellMargin;
    NSString *name =[NSString stringWithFormat:@"@%@",_status.retweeted_status.user.name];
    CGSize nameSize = [name sizeWithFont:IWNameFont];
    // 强转结构体,因为不知道这样的是哪个结构体
    _retweetNameViewF = (CGRect){{nameX,nameY},nameSize};
    
    // 内容
    CGFloat textX = IWCellMargin;
    CGFloat textY = CGRectGetMaxY(_retweetNameViewF) + IWCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = IWTextFont;
    // Size:限制尺寸,限制文字最高多少最宽多少
    CGRect textR = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(IWScreenWidth - 2 * IWCellMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil];
    _retWeetTextViewF = (CGRect){{textX,textY},textR.size};
    
    
    CGFloat retweetH = CGRectGetMaxY(_retWeetTextViewF) + IWCellMargin;
    if (_status.retweeted_status.pic_urls.count) { // 转发有配图
        // 配图的frame
        CGFloat photoX = textX;
        CGFloat photoY = CGRectGetMaxY(_retWeetTextViewF) + IWCellMargin;
        CGSize photoSize = [self photosSizeWithCount:_status.retweeted_status.pic_urls.count ];
        _retWeetphotosViewF = (CGRect){{photoX,photoY},photoSize};
        // 转发的高度 = 最大的配图y+一段间距
        retweetH = CGRectGetMaxY(_retWeetphotosViewF) + IWCellMargin;
    }
    

    // 整个转发微博的frame
    CGFloat retweetY = CGRectGetMaxY(_originalViewF);

    _retweetViewF = CGRectMake(0, retweetY, IWScreenWidth, retweetH);

}
@end
