//
//  HMEmoticonsController.h
//  黑马5期微博
//
//  Created by teacher on 15/4/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEmoticonsController, HMEmoticon;

@protocol EmoticonsControllerDelegate <NSObject>

- (void)emoticonsController:(HMEmoticonsController *)emoticonsController emoticon:(HMEmoticon *)emoticon;

@end

@interface HMEmoticonsController : UIViewController

@property (nonatomic, weak) id<EmoticonsControllerDelegate> delegate;
@end
