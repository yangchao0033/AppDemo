//
//  HMEmoticonSection.h
//  黑马5期微博
//
//  Created by teacher on 15/4/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//
// 组模型, 一个组模型对应一组数据
// 每组数据中最多有21个表情对象

#import <Foundation/Foundation.h>

@interface HMEmoticonSection : NSObject

// 当前组的名称(当前表情类型的名称)
@property (nonatomic, copy) NSString *emoticon_group_name;
// 记录当前组的表情是只读的还是可读可写的
@property (nonatomic, copy) NSString *emoticon_group_type;
// 当前组表情的文件夹名称
@property (nonatomic, copy) NSString *emoticon_group_path;

// 数组中存放着最多21个表情
@property (nonatomic, strong) NSMutableArray  *emoticons;

// 通过一个字典创建一个模型
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
