//
//  IWPhotosView.h
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWPhotosView : UIView

// 配图数组(IWPhoto)
@property (nonatomic, strong) NSArray *pic_urls;
- (void)show;
@end
