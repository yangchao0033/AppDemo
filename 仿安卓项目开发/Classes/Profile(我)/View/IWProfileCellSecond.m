//
//  IWProfileCellSecond.m
//  新浪微博
//
//  Created by yc on 15-4-5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "IWProfileCellSecond.h"
#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "IWUserInfo.h"


@interface IWProfileCellSecond ()
@property (nonatomic, weak) IBOutlet UILabel *statusCount;
@property (nonatomic, weak) IBOutlet UILabel *fanceCount;
@property (nonatomic, weak) IBOutlet UILabel *noticeCount;
@end
@implementation IWProfileCellSecond

- (void)awakeFromNib {
    // Initialization code
    [self loadData];
}

// cell2
- (void)loadData
{
    IWUserInfo *userInfo = [IWUserInfo sharedUserInfo];
    NSDictionary *userDict = userInfo.userInfoDict;
    if (userDict) {
        self.statusCount.text = userDict[@"statuses_count"];
        self.fanceCount.text = userDict[@"followers_count"];
        self.noticeCount.text = userDict[@"friends_count"];
        return;
    }
    [IWUserInfo loadDataWithBlock:^(NSDictionary *dict) {
        userInfo.userInfoDict = dict;
        self.statusCount.text = [NSString stringWithFormat:@"%@", dict[@"statuses_count"]];
        self.fanceCount.text = [NSString stringWithFormat:@"%@", dict[@"followers_count"]];
        self.noticeCount.text = [NSString stringWithFormat:@"%@", dict[@"friends_count"]];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
