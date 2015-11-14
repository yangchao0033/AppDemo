//
//  IWStatusCell.h
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
// 为什么用@class,为了节省编译时间
@class IWStatusFrame;
@interface IWStatusCell : UITableViewCell

/**
 *  VM(包含status数据,所有子控件frame)
 */
@property (nonatomic, strong) IWStatusFrame *sf;

/**
 *  快速创建cell
 *
 */
+ (instancetype)cellWithTable:(UITableView *)tableView;

@end
