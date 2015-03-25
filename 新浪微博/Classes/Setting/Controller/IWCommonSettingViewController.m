//
//  IWCommonSettingViewController.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWCommonSettingViewController.h"
#import "IWBaseSetting.h"
#import "IWFontSizeViewController.h"
#import "IWFontSizeTool.h"
#import "UIImageView+WebCache.h"

#define IWFontSizeNote @"fontSizeNote"

@interface IWCommonSettingViewController ()

@property (nonatomic, weak) IWSettingItem *fontSize;

@end

@implementation IWCommonSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    // 添加第4组
    [self setUpGroup4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange) name:IWFontSizeNote object:nil];
   
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 只要点击字体界面的cell就会调用
- (void)fontSizeChange
{
    // 修改模型
    _fontSize.subTitle = [IWFontSizeTool fontSize];
    // 刷新界面
    [self.tableView reloadData];
}

- (void)setUpGroup0
{
    // 阅读模式
    IWSettingItem *read = [IWSettingItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    
   
    // 字体大小
    IWSettingItem *fontSize = [IWSettingItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr = [IWFontSizeTool fontSize];
    if (fontSizeStr) {
        fontSize.subTitle = fontSizeStr;
    }else{
        // 设置字体
        fontSize.subTitle = @"小";
        // 存储字体
        [IWFontSizeTool saveFontSize:@"小"];
        
    }
    fontSize.destVcClass = [IWFontSizeViewController class];
    // 显示备注
    IWSwitchItem *remark = [IWSwitchItem itemWithTitle:@"显示备注"];
    
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 图片质量
    IWArrowItem *quality = [IWArrowItem itemWithTitle:@"图片质量" ];

    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 声音
    IWSwitchItem *sound = [IWSwitchItem itemWithTitle:@"声音" ];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    IWSettingItem *language = [IWSettingItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}



- (void)setUpGroup4
{
    __weak typeof(self) weakSelf = self;
    // 清空图片缓存
    IWArrowItem *clearImage = [IWArrowItem itemWithTitle:@"清空图片缓存"];
    // kb
    CGFloat size = [[SDImageCache sharedImageCache] getSize] / 1024.0;
    NSString *sizeStr = [NSString stringWithFormat:@"%.1fKB",size];;
    if (size > 1024) {
        // MB
        CGFloat floatSize = size / 1024.0;
        sizeStr = [NSString stringWithFormat:@"%.1fMB",floatSize];
    }
    clearImage.subTitle = sizeStr;
    clearImage.option = ^(IWCheakItem *item){
        // 清空所有的硬盘缓存
        [[SDImageCache sharedImageCache] clearDisk];
        item.subTitle = nil;
        [weakSelf.tableView reloadData];
    };
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}

@end
