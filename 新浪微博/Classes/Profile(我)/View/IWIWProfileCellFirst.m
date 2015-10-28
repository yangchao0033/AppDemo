//
//  IWIWProfileCellFirst.m
//  新浪微博
//
//  Created by yc on 15-4-5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "IWIWProfileCellFirst.h"
#import "AFNetworking.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "UIImageView+WebCache.h"
#import "IWUserInfo.h"


@interface IWIWProfileCellFirst ()
@property (nonatomic, weak)IBOutlet UIImageView *icon;
@property (nonatomic, weak)IBOutlet UILabel *name;
@property (nonatomic, weak)IBOutlet UILabel *desc;
@end

@implementation IWIWProfileCellFirst

- (void)awakeFromNib {
    // Initialization code
    [self loadData];
}

- (void)loadData
{
    IWUserInfo *userInfo = [IWUserInfo sharedUserInfo];
    NSDictionary *userDict = userInfo.userInfoDict;
    if (userDict) {
        NSURL *urlIcon = [NSURL URLWithString:userDict[@"avatar_large"]];
        [self.icon sd_setImageWithURL:urlIcon];
        self.name.text = userDict[@"screen_name"];
        self.desc.text = [NSString stringWithFormat:@"简介：%@", userDict[@"description"]];
        return;
    }
    [IWUserInfo loadDataWithBlock:^(NSDictionary *dict) {
        userInfo.userInfoDict = dict;
        NSURL *urlIcon = [NSURL URLWithString:dict[@"avatar_large"]];
        [self.icon sd_setImageWithURL:urlIcon];
        self.name.text = dict[@"screen_name"];
        self.desc.text = dict[@"description"];
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
