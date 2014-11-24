//
//  IWNewFeatureCell.h
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWNewFeatureCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath itemCount:(NSInteger)count;

@end
