//
//  IWStatusCell.m
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatusCell.h"
#import "IWOriginalView.h"
#import "IWRetweetView.h"
#import "IWStatusToolBar.h"
#import "IWStatusFrame.h"

@interface IWStatusCell ()

@property (nonatomic, weak) IWOriginalView *originalView;
@property (nonatomic, weak) IWRetweetView *retweetView;
@property (nonatomic, weak) IWStatusToolBar *statusToolBar;

@end

@implementation IWStatusCell

// 创建Cell
+ (instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[IWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

// 想要cell在一创建的时候做事情,一定要重写这个方法,而不是initWithFrame
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildeView];
        
        // 清空cell的背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildeView
{
    // 原创微博
    IWOriginalView *originalView = [[IWOriginalView alloc] init];
    _originalView = originalView;
    [self addSubview:originalView];
    
    // 转发微博
    IWRetweetView *retweetView = [[IWRetweetView alloc] init];
    _retweetView = retweetView;
    [self addSubview:retweetView];
    
    // 工具条
    IWStatusToolBar *statusToolBar = [[IWStatusToolBar alloc] init];
    _statusToolBar = statusToolBar;
    [self addSubview:statusToolBar];
}

- (void)setSf:(IWStatusFrame *)sf
{
    _sf = sf;
    
    // 设置所有子控件的frame
    // 设置原创微博frame
    _originalView.frame = sf.originalViewF;
    // 传递VM模型给originalView,sf包含了originalView内部所有子控件的frame和内容
    _originalView.sf = sf;
   
    // 设置转发微博frame
    _retweetView.frame = sf.retweetViewF;
    // 设置转发微博所有子控件frame和内容
    _retweetView.sf = sf;


    // 设置工具条
    _statusToolBar.frame = sf.toolBarF;
    _statusToolBar.status = sf.status;
    
}

@end
