//
//  HMMessageCell.h
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMMessageFrame, HMMessageCell;



@interface HMMessageCell : UITableViewCell

@property (nonatomic, strong) HMMessageFrame *messageFrame;
@property (nonatomic, copy) void(^displayIconBlock)(UIImageView *icon);

+ (instancetype)messageCellWithTableView:(UITableView *)tableView;

//- (void)messageCell:(HMMessageCell *)cell willIconDisplayWith:(void(^)(UIImageView *))display;
@end
