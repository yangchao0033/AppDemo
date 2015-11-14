//
//  IWFontSizeViewController.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWFontSizeViewController.h"
#import "IWBaseSetting.h"
#import "IWFontSizeTool.h"

#define IWFontSizeNote @"fontSizeNote"

@interface IWFontSizeViewController ()

@property (nonatomic, weak) IWCheakItem *selCheakItem;

@end

@implementation IWFontSizeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    
}
- (void)setUpGroup0
{
    __weak typeof(self) weakSelf = self;
    // 大
    IWCheakItem *big = [IWCheakItem itemWithTitle:@"大"];
   
    big.option = ^(IWCheakItem *item){
        [weakSelf selItem:item];
    };
    // 中
    IWCheakItem *middle = [IWCheakItem itemWithTitle:@"中"];
    middle.option = ^(IWCheakItem *item){
        [weakSelf selItem:item];
    };
    // 小
    IWCheakItem *small = [IWCheakItem itemWithTitle:@"小"];
    small.option = ^(IWCheakItem *item){
        [weakSelf selItem:item];
    };
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    
    // 默认选中item
    [self selItemWithTitle:[IWFontSizeTool fontSize]];
    
   
}

// 根据字体选中item
- (void)selItemWithTitle:(NSString *)title
{
    for (IWGroupItem *group in self.groups) {
        for (IWCheakItem *item in group.items) {
            if ([item.title isEqualToString:title]) {
                [self selItem:item];
            }
        }
    }
}

// 当点击某一行的时候,选中新的字体尺寸调用
- (void)selItem:(IWCheakItem *)item
{
    _selCheakItem.cheak = NO;
    item.cheak = YES;
    _selCheakItem = item;
    
    [self.tableView reloadData];

    // 保存当前选中的字体
    [IWFontSizeTool saveFontSize:item.title];
    
    // 发出通知,修改commomSetting的字体模型
    [[NSNotificationCenter defaultCenter] postNotificationName:IWFontSizeNote object:nil];

}

@end
