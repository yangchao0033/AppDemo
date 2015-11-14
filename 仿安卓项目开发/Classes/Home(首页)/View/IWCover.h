//
//  IWCover.h
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IWCoverDismissCompletion)();

@interface IWCover : UIView

@property (nonatomic, copy) IWCoverDismissCompletion dismissCompletion;

+ (instancetype)show;

// 是否需要深灰色
@property (nonatomic, assign) BOOL dimBackground;

@end
