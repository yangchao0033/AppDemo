//
//  HMEmoticonsController.m
//  黑马5期微博
//
//  Created by teacher on 15/4/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMEmoticonsController.h"
#import "HMEmoticonSection.h"
#import "HMEmoticonCell.h"
#import "HMEmoticonsManager.h"

typedef enum{
    HMToolBarBtnTypeNear = 100,
    HMToolBarBtnTypeNormal,
    HMToolBarBtnTypeEmoji,
    HMToolBarBtnTypeLXH
}HMToolBarBtnType;

@interface HMEmoticonsController ()<UICollectionViewDataSource, UICollectionViewDelegate>
// 布局对象
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
// 表情容器
@property (weak, nonatomic) IBOutlet UICollectionView *emoticonView;
- (IBAction)emoticonToolbarClick:(UIBarButtonItem *)sender;

@end

@implementation HMEmoticonsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.计算layout
    NSUInteger col = 7;
    NSUInteger row = 3;
    NSUInteger margin = 10;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 2.计算每一个cell的宽高
    CGFloat emoticonWidth = (screenWidth - (col + 1) * margin) / col;
    CGFloat emoticonHeight = emoticonWidth;
    
    // 3.设置布局
    self.layout.itemSize = CGSizeMake(emoticonWidth, emoticonHeight);
    self.layout.minimumInteritemSpacing = margin;
    self.layout.minimumLineSpacing = margin;
    // 设置组与组之间的边距
    self.layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.emoticonView.pagingEnabled = YES;
}

#pragma mark - UICollectionViewDataSource
// 告诉系统有多组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [HMEmoticonsManager shareManager].emotionSections.count;
}

// 告诉系统每组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 1.取出对应的组
    HMEmoticonSection *categoryScetion = [HMEmoticonsManager shareManager].emotionSections[section];
    // 2.返回对应组对应的行数
    return categoryScetion.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HMEmoticonCell identifier] forIndexPath:indexPath];
    
    // 1.取出当前组
     HMEmoticonSection *categoryScetion = [HMEmoticonsManager shareManager].emotionSections[indexPath.section];
    // 2.取出当前表情模型
    HMEmoticon *emoticon = categoryScetion.emoticons[indexPath.item];
    cell.emoticon = emoticon;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出当前组
    HMEmoticonSection *categoryScetion = [HMEmoticonsManager shareManager].emotionSections[indexPath.section];
    // 2.取出当前表情模型
    HMEmoticon *emoticon = categoryScetion.emoticons[indexPath.item];
    
    // 根据当前的选中填充最近使用
    // 1.拿到最近使用的组
    HMEmoticonSection *nearSection = [HMEmoticonsManager shareManager].emotionSections[0];
    // 2.更新组模型中的数据

    // 2.2判断当前选中的表情是否在最近使用中存在
    BOOL contain = NO;
    for (HMEmoticon *oldEmoticon in nearSection.emoticons) {
        if ([oldEmoticon.chs isEqualToString:emoticon.chs] ||
            [oldEmoticon.emoji isEqualToString:emoticon.emoji]) {
            contain = YES;
            break;
        }
    }
    // 如果是删除键就不添加
    if (emoticon.isDeleteButton) {
        contain = YES;
    }
    if (!contain) {
        // 2.1移除删除按钮之前的表情
        [nearSection.emoticons removeObjectAtIndex:nearSection.emoticons.count - 2];
        
        // 2.3将表情插入到最前面
        [nearSection.emoticons insertObject:emoticon atIndex:0];
        [self.emoticonView reloadData];
    }
    
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emoticonsController:emoticon:)]) {
        [self.delegate emoticonsController:self emoticon:emoticon];
    }
}

- (IBAction)emoticonToolbarClick:(UIBarButtonItem *)sender
{

    // 1.定义变量记录需要跳过的组数
    NSUInteger count = 0;
    // Emoji = 2
    for (int i = 0; i < sender.tag; i++) { // 0 1
        NSNumber *currentSectionCount = [HMEmoticonsManager shareManager].categroySections[i];
        count += currentSectionCount.intValue; // 7
    }

    CGRect rect = self.emoticonView.frame;
    rect.origin.x = count * rect.size.width;
    [self.emoticonView scrollRectToVisible:rect animated:NO];
}
@end
