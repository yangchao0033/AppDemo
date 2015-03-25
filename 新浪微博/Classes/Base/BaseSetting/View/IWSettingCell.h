//
//  IWSettingCell.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWSettingItem;
@interface IWSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWSettingItem *item;

@end
