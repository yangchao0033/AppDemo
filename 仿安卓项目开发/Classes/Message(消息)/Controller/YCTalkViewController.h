//
//  ViewController.h
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCTalkViewController;

@interface YCTalkViewController : UIViewController
@property (nonatomic, copy) void(^displayIconBlock)(UIImageView *icon);
- (void)cellDidSelectedAndComplitionWith:(void(^)(UIImageView *icon))block;
@end

