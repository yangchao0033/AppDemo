//
//  HMEmoticonSection.m
//  黑马5期微博
//
//  Created by teacher on 15/4/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMEmoticonSection.h"
#import "HMEmoticon.h"

// 2.加载info.plist
// 3.加载所有表情数据
// 4.将所有加载到的表情数据分组 (21个, 最后一个是删除按钮)
// 5.将所有组的数据, 存储到一个数组中返回
@implementation HMEmoticonSection
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.emoticon_group_name = dict[@"emoticon_group_name"];
        self.emoticon_group_type = dict[@"emoticon_group_type"];
        self.emoticon_group_path = dict[@"emoticon_group_path"];
        self.emoticons = [NSMutableArray array];
    }
    return self;
}

@end
