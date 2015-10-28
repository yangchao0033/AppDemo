//
//  HMEmoticon.m
//  黑马5期微博
//
//  Created by teacher on 15/4/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMEmoticon.h"
#import "NSString+Emoji.h"

@implementation HMEmoticon

// dict : 当前表情模型对应的字典
// path : 单签表情所属分类的目录名称
- (instancetype)initWithDict:(NSDictionary *)dict path:(NSString *)path
{
    if (self = [super init]) {
        self.chs = dict[@"chs"];
        self.cht = dict[@"cht"];
        self.png = dict[@"png"];
        self.type = dict[@"type"];
        self.code = dict[@"code"];
        if (self.type.intValue == 0) {
            self.imagePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Emoticons/%@/%@", path, self.png]];
        }else
        {
            // 处理emoji表情
            self.emoji = [self.code emoji];
        }
    }
    return self;
}
@end
