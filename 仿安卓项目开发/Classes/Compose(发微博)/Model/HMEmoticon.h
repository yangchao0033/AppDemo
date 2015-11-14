//
//  HMEmoticon.h
//  黑马5期微博
//
//  Created by teacher on 15/4/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//
// 表情模型, 一个模型对应一个表情
#import <Foundation/Foundation.h>

@interface HMEmoticon : NSObject

// 十六进制的emoji数据
@property (nonatomic, copy) NSString *code;
// 通过十六进制转换后的emoji表情unicode
@property (nonatomic, copy) NSString *emoji;

// 中文简体
@property (nonatomic, copy) NSString *chs;
// 中文繁体
@property (nonatomic, copy) NSString *cht;
// 图片名称
@property (nonatomic, copy) NSString *png;
// 表情类型(图片? emoji)
@property (nonatomic, copy) NSString *type;
// 图片的完整路径
@property (nonatomic, copy) NSString *imagePath;

// 记录是否是删除按钮
@property (nonatomic, assign, getter=isDeleteButton) BOOL deleteButton;

- (instancetype)initWithDict:(NSDictionary *)dict path:(NSString *)path;
@end
