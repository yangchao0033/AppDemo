//
//  AppInfoCell.h
//  03-网络图片
//
//  Created by 刘凡 on 15/3/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
@end
