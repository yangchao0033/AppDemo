//
//  IWComposeBar.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWComposeBar;
// 枚举注意:枚举类型以类名开头
typedef enum : NSUInteger {
    IWComposeBarButtonStylePicture, // 相册
    IWComposeBarButtonStyleMention, // 提及
    IWComposeBarButtonStyleTrend, // 趋势
    IWComposeBarButtonStyleEmoticon,// 表情
    IWComposeBarButtonStyleKeyboard // 键盘
} IWComposeBarButtonStyle;


@protocol IWComposeBarDelegate <NSObject>

@optional
- (void)composeBar:(IWComposeBar *)bar didClickBtn:(IWComposeBarButtonStyle)style;

@end

@interface IWComposeBar : UIView

@property (nonatomic, weak) id<IWComposeBarDelegate> delegate;

@end
