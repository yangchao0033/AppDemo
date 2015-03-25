//
//  IWComposePhotosView.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWComposePhotosView : UIView

- (void)addImage:(UIImage *)image;

@property (nonatomic, strong) NSMutableArray *images;

@end
