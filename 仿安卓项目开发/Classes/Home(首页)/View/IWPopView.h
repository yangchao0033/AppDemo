//
//  IWPopView.h
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWPopView : UIImageView

// 内容视图
@property (nonatomic, weak) UIView *contentView;
+ (instancetype)showInRect:(CGRect)rect;
+ (void)dismiss;

@end
