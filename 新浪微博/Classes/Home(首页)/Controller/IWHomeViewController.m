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

#import "AFNetworking.h"

#import "IWAccountTool.h"
#import "IWAccount.h"

#import "IWStatus.h"
#import "MJExtension.h"
#import "IWUser.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"


@interface IWHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic, weak) IWTitleButton *titleButton;

@property (nonatomic, strong) IWPopViewController *popVc;
@end

@implementation IWHomeViewController
- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}
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
    
    // 获取最新的微博数据
    [self loadNewStatuses];
    
    // 添加上下拉刷新控件
    [self setUpRefresh];

}

- (void)setUpRefresh
{
    // 添加下拉刷新控件
    // 当你下拉的时候就会调用Target对象action方法
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses)];
    
    
    // 添加上拉刷新控件
    // 当你上拉的时候就会调用Target对象action方法
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
}

// 获取最多的微博数据
- (void)loadMoreStatuses
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    // 拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    
    // 判断数组有没有微博值
    if (self.statuses.count) {
        IWStatus *s = [self.statuses lastObject];
        params[@"max_id"] = @([s.idstr longLongValue] - 1);
    }
    
    // 发送get请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 停止尾部刷新
        [self.tableView footerEndRefreshing];
        
        
        // 把返回的数据转换成模型
        NSArray *dictArr = responseObject[@"statuses"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            IWStatus *s =  [IWStatus objectWithKeyValues:dict];
            [arrM addObject:s];
        }
        // 用成员变量保存数据
        // 遍历arrM所有元素添加self.statuses,而不是直接把arrM数组添加
        [self.statuses addObjectsFromArray:arrM];
        
        // 获取到新数据的时候,刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
     
// 获取最新的微博数据
- (void)loadNewStatuses
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    
    // 判断数组有没有微博值
    if (self.statuses.count) {
        IWStatus *s = [self.statuses firstObject];
        params[@"since_id"] = s.idstr;
    }
    
    // 发送get请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 停止头部刷新
        [self.tableView headerEndRefreshing];
        
        // 把返回的数据转换成模型
        NSArray *dictArr = responseObject[@"statuses"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
          IWStatus *s =  [IWStatus objectWithKeyValues:dict];
         [arrM addObject:s];
        }
        NSLog(@"%d",arrM.count);
        NSRange range = NSMakeRange(0, arrM.count);
        // location : 插入哪个角标
        // len :插入个数:最新微博数组的个数
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        // 用成员变量保存数据
        [self.statuses insertObjects:arrM atIndexes:indexSet];
        
        // 获取到新数据的时候,刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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



#pragma mark - Table view data source
// 有多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    IWStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    
    // 发送异步下载,不能直接拿到cell去设置图片,下载完一个,给模型赋值
    // 下载完之后,指定刷新某一行
    
    // 用了异步请求,防止阻塞主线程
    // 解决了循环利用
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // Configure the cell...
    
    return cell;
}

// 点击一行Cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWOneViewController *one = [[IWOneViewController alloc] init];
   
    [self.navigationController pushViewController:one animated:YES];
    
}





@end
