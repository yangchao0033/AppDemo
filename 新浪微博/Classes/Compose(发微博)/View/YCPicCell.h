//
//  YCPicCell.h
//  新浪微博
//
//  Created by yc on 15-4-19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCPicCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSIndexPath *path;
@property (nonatomic, assign) NSUInteger photosCount;
+ (NSString *)identifier;
@end
