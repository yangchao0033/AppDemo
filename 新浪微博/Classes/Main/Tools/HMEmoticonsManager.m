//
//  HMEmoticonsManager.m
//  黑马5期微博
//
//  Created by teacher on 15/4/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMEmoticonsManager.h"


@implementation HMEmoticonsManager

static HMEmoticonsManager *_instance;
+ (instancetype)shareManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HMEmoticonsManager alloc] init];
    });
    return _instance;
}

// 1.加载最外面的plist
- (NSArray *)loadEmoticonsSections
{
    // 1.加载emoticons.plist
    // 1.拼接emoticons.plist的全路径
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"Emoticons/emoticons.plist"];
    // 2.通过全路径加载数组
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    //    DDLogInfo(@"%@", arr);
    
    // 定义数组保存所有创建好得组模型
    NSMutableArray *result = [NSMutableArray array];
    // 3.遍历数组取出所有的分类
    for (NSDictionary *dict in arr) {
        // 3.1通过当前分类的字典创建组模型
        // 也就是说, 会将当前分类中的所有表情按照21个一组进行封装
        // 返回的数组中存放的是组模型
        NSArray *sections = [self loadEmoticonsSectionsWithDict:dict];
        // 3.2将当前分类的组模型放到大数组中
        [result addObjectsFromArray:sections];
        
    }
    return result;
}

// 2.加载info.plist
// 根据字典, 加载当前分类中所有的表情
// 并且会将表情封装为组模型, 每组21个
// 返回当前分类中又多少组表情
- (NSArray *)loadEmoticonsSectionsWithDict:(NSDictionary *)dict
{
    // 1.取出分类的文件夹名称
    NSString *name = dict[@"emoticon_group_path"];
    //    DDLogInfo(@"%@", name);
    // 2.拼接每组数据的全路径
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Emoticons/%@/info.plist", name]];
    // 3.加载分类的字典
    NSDictionary *categoryDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // 4.获取分类中的数组
    NSArray *categoryArr = categoryDict[@"emoticon_group_emoticons"];
    
    
    // 传递当前分类所有的表情字典, 以及当前分类的字典
    return [self loadEmoticonsSectionsWithArray:categoryArr dict:dict];
}

// 3.处理info.plist中的数据
// 处理当前分类中的所有表情
// 生成组模型
// 返回当前分类的所有组模型的数组
// 一组只能有21个表情, 而且最后一个是删除按钮
- (NSArray *)loadEmoticonsSectionsWithArray:(NSArray *)array dict:(NSDictionary *)dict
{
//    NSLog(@"%@", dict);
    // 1.定义数组保存当前分类所有的组模型
    NSMutableArray *sections = [NSMutableArray array];
    
    // 2.遍历生成组模型
    // 2.1定义一组中最多能存放的表情数量
    NSUInteger maxCount = 20;
    // 2.2计算当前分类能够生成多少个组模型
    // (50 - 1) / 20
    NSUInteger sectionCount =  (array.count - 1) / maxCount + 1;
    
    // 2.3遍历, 每遍历一次就会生成一个组模型
    // sectionCount == 3
    for (int i = 0; i < sectionCount; i++) {
        // 2.3.1创建组模型
        HMEmoticonSection *sectionModel = [[HMEmoticonSection alloc] initWithDict:dict];
        // 2.3.2生成当前组的所有表情模型
        for (int j = 0; j < maxCount; j++) {
            // 2.3.2.1计算索引
            // 第一次 0 ~19
            // 第二次 20~39
            // 第三次 40~59
            NSUInteger index = j + (i * maxCount);
            // 2.3.2.2判断是否越界
            // 获取数据
            NSDictionary *emoticonDict = nil;
            // 注意: 如果在判断完没有越界之后再创建表情模型, 那么如果这一组不到20个, 组模型中就不会保存20个表情模型
            // 所以: 为了能够不管这一组是否有20个表情 , 都让表情模型保存20个吧表情, 那么我们只需要在没有越界时取出对应的表情字典创建模型即可, 如果越界我们就创建一个空得模型占位
            if (index < array.count) {
                // 获取数据
                emoticonDict = array[index];
            }
            // 创建表情模型
            HMEmoticon *emoticon = [[HMEmoticon alloc] initWithDict:emoticonDict path:sectionModel.emoticon_group_path];
        
            // 添加表情到组模型中
            [sectionModel.emoticons addObject:emoticon];
        }
        
        // 创建一个空得表情模型代表删除按钮
        HMEmoticon *emoticon = [[HMEmoticon alloc] init];
        emoticon.deleteButton = YES;
        // 添加表情到组模型中
        [sectionModel.emoticons addObject:emoticon];
        // 添加组模型到数组中
        [sections addObject:sectionModel];
    }
    
    // 记录当前分类有多少组数据
    [self.categroySections addObject:@(sections.count)];
    return [sections copy];
}

#pragma mark - lazy
- (NSArray *)emotionSections
{
    if (!_emotionSections) {
        _emotionSections = [self loadEmoticonsSections];
    }
    return _emotionSections;
}

- (NSMutableArray *)categroySections
{
    if (!_categroySections) {
        _categroySections = [NSMutableArray array];
    }
    return _categroySections;
}

- (NSArray *)emotions
{
    if (!_emotions) {
        NSMutableArray *temp = [NSMutableArray array];
        for (HMEmoticonSection *section in self.emotionSections) {
            [temp addObjectsFromArray:section.emoticons];
        }
        _emotions = [temp copy];
    }
    return _emotions;
}

@end
