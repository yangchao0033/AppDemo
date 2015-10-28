//
//  HMEmoticonsManager.h
//  黑马5期微博
//
//  Created by teacher on 15/4/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//
// 专门用于加载表情数据的工具类
// 单利
#import <Foundation/Foundation.h>
#import "HMEmoticonSection.h"
#import "HMEmoticon.h"

@interface HMEmoticonsManager : NSObject
// 单利, 获取当前实例
+ (instancetype)shareManager;

// 存放着所有表情的组
@property (nonatomic, strong) NSArray *emotionSections;

// 存放所有的表情模型
@property (nonatomic, strong) NSArray *emotions;


// 通过数组记录所有分类表情的组数
// 注意: 数组中记录的值是有序的
// 最近-->默认-->Emoji-->浪小花
@property (nonatomic, strong) NSMutableArray *categroySections;
// 加载所有组的数据
// 1.加载emoticons.plist
// 2.加载info.plist
// 3.加载所有表情数据
// 4.将所有加载到的表情数据分组 (21个, 最后一个是删除按钮)
// 5.将所有组的数据, 存储到一个数组中返回
//+ (NSArray *)loadEmoticonsSections;
@end
