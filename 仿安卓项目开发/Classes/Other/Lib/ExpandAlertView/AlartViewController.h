//
//  AlartViewController.h
//  MyReader
//
//  Created by broy denty on 14-8-4.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpendableAlartViewDelegate <NSObject>

- (void)positiveButtonAction;
- (void)negativeButtonAction;
- (void)closeButtonAction;
@end
@interface AlartViewController : UIViewController
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,weak) id<ExpendableAlartViewDelegate> expendAbleAlartViewDelegate;
- (void)showView:(UIViewController *)VC;
CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ);


CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ);

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
