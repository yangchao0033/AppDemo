//
//  IWTextView.h
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWTextView : UITextView

@property(nonatomic,copy)   NSString *placeholder;

// 好处,不让内部的控件暴露,模仿
@property (nonatomic, assign) BOOL hidePlaceHolder;

@end
