//
//  HMEmoticonCell.h
//  黑马5期微博
//
//  Created by teacher on 15/4/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticon;

@interface HMEmoticonCell : UICollectionViewCell

+ (NSString *)identifier;
// 表情模型
@property (nonatomic, strong) HMEmoticon *emoticon;
@end
