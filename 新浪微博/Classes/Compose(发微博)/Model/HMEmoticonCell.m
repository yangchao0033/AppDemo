//
//  HMEmoticonCell.m
//  黑马5期微博
//
//  Created by teacher on 15/4/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMEmoticonCell.h"
#import "HMEmoticon.h"
@interface HMEmoticonCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *emojiView;

@end

@implementation HMEmoticonCell

+ (NSString *)identifier
{
    return @"emoticonCell";
}

- (void)setEmoticon:(HMEmoticon *)emoticon
{
    _emoticon = emoticon;
    self.emojiView.hidden = YES;
    
    // 1.判断是否是图片表情
    if (_emoticon.chs != nil &&
        _emoticon.imagePath != nil) {
        // 设置表情图片
        self.iconView.image = [[UIImage alloc] initWithContentsOfFile:_emoticon.imagePath];
    }else
    {
        self.iconView.image = nil;
    }
    
    if(_emoticon.emoji != nil)
    {
        // 设置emoji表情
        self.emojiView.text = _emoticon.emoji;
        self.emojiView.font = [UIFont systemFontOfSize:32];
        self.emojiView.hidden = NO;
    }
    
    if (_emoticon.isDeleteButton) {
        self.iconView.image = [UIImage imageNamed:@"compose_emotion_delete_highlighted"];
    }
    
}
@end
