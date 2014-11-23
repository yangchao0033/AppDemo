//
//  IWHomeViewController.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHomeViewController.h"
#import "IWTitleButton.h"
#import "IWPopView.h"
#import "IWPopViewController.h"
#import "IWCover.h"
#import "IWOneViewController.h"


@interface IWHomeViewController ()
@property (nonatomic, weak) IWTitleButton *titleButton;

@property (nonatomic, strong) IWPopViewController *popVc;
@end

@implementation IWHomeViewController

- (IWPopViewController *)popVc
{
    if (_popVc == nil) {
        _popVc = [[IWPopViewController alloc] init];
    }
    return _popVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置首页导航条的内容
    [self setUpNavBar];

}


#pragma mark - 设置首页导航条的内容
- (void)setUpNavBar
{

    // 创建左边item
    UIBarButtonItem *left = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch)];
    self.navigationItem.leftBarButtonItem = left;
    
    // 创建右边item
    UIBarButtonItem *right = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:nil action:nil];
    self.navigationItem.rightBarButtonItem = right;
    
    // titleView
    IWTitleButton *titleButton = [IWTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

#pragma mark - 点击标题按钮的时候调用
- (void)titleButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        
        // 添加遮盖
        IWCover *cover = [IWCover show];
        cover.dimBackground = YES;
        cover.dismissCompletion = ^{
            [IWPopView dismiss];
            
            button.selected = NO;
            
        };
        
        // 通常显示在最前面的东西都加在窗口上
        // 弹出pop菜单
       IWPopView *popView = [IWPopView showInRect:CGRectMake((self.view.width - 200) * 0.5, 55, 200, 200)];
        
        popView.contentView = self.popVc.view;
       
    }else{
        [IWPopView dismiss];
    }
   
    
}


// 点击导航条左边按钮调用
- (void)friendsearch
{
    IWLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"123213";
    // Configure the cell...
    
    return cell;
}

// 点击一行Cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWOneViewController *one = [[IWOneViewController alloc] init];
    
    // 在push的时候隐藏底部条,隐藏系统自带的tabBar
    one.hidesBottomBarWhenPushed = YES;
    
//    // 设置One控制器的导航条
//    // 设置左边的按钮
//    UIBarButtonItem *popPre = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popPre)];
//    
//    // 设置导航条的按钮
//    one.navigationItem.leftBarButtonItem = popPre;
//    
//    // 设置右边的按钮
//    UIBarButtonItem *popRoot = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popRoot)];
//    
//    // 设置导航条的按钮
//    one.navigationItem.rightBarButtonItem = popRoot;

    
    [self.navigationController pushViewController:one animated:YES];
    
}





@end
