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

#import "IWHttpTool.h"
#import "IWStatusTool.h"

#import "IWUserTool.h"

#import "IWStatusCell.h"
#import "IWStatusFrame.h"



@interface IWHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrameArr;

@property (nonatomic, weak) IWTitleButton *titleButton;

@property (nonatomic, strong) IWPopViewController *popVc;

// 记录当前有没有刷新更新的数据
@property (nonatomic, assign) BOOL isrefreshing;

@end

@implementation IWHomeViewController
- (NSMutableArray *)statusFrameArr
{
    if (_statusFrameArr == nil) {
        _statusFrameArr = [NSMutableArray array];
    }
    return _statusFrameArr;
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
    
    // 添加上下拉刷新控件
    [self setUpRefresh];
    
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = IWColor(201, 201, 201);
    

}

- (void)setUpRefresh
{
    // 添加下拉刷新控件
    // 当你下拉的时候就会调用Target对象action方法
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses)];
    
    // 手动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    
    // 添加上拉刷新控件
    // 当你上拉的时候就会调用Target对象action方法
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
}

- (void)refresh
{
    // 下拉效果
    [self.tableView headerBeginRefreshing];
}

// 获取最多的微博数据
- (void)loadMoreStatuses
{
    
    // 上啦刷新 通知tabBar记录总共的未读数
    /**
     *  NotificationName:通知的名称
        object:谁发出的通知
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:IWBeginMoreNote object:nil];

    
      // 判断数组有没有微博值
    id maxId = nil;
    if (self.statusFrameArr.count) {
        IWStatusFrame *sf = [self.statusFrameArr lastObject];
        IWStatus *s = sf.status;
        // 设置maxId值
        maxId = @([s.idstr longLongValue] - 1);

    }
    // 获取更多的微博数据
    [IWStatusTool moreStatusWithMaxID:maxId success:^(NSArray *statuses) {
        
        // IWStatus -> VM -> IWStatusFrame(所有子控件frame 和 IWStatus)
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *s  in statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = s;
            
            [arrM addObject:statusF];
        }
        
        
        // 1.停止尾部刷新
        [self.tableView footerEndRefreshing];
        
        // 2.用成员变量保存数据
        // 遍历arrM所有元素添加self.statuses,而不是直接把arrM数组添加
        [self.statusFrameArr addObjectsFromArray:arrM];
        
        // 获取到新数据的时候,刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
   
    
}


// 获取最新的微博数据
- (void)loadNewStatuses
{
    
    // 正在刷新,就不需要发送请求
    if (_isrefreshing) return;
    
    // 加载最新的时候发出通知,把之前记录总共的未读数清空
     [[NSNotificationCenter defaultCenter] postNotificationName:IWBeginNewNote object:nil];
    
    // 正在刷新
    _isrefreshing = YES;
    id sinceID = nil;
    

    // 判断数组有没有微博值
    if (self.statusFrameArr.count) {
        IWStatusFrame *sf = [self.statusFrameArr firstObject];
        IWStatus *s = sf.status;
        sinceID = s.idstr;
  
    }

    // 获取最新微博数据
    [IWStatusTool newStatusWithSinceID:sinceID success:^(NSArray *statuses) {
        
        // 刷新结束
        _isrefreshing = NO;
        // IWStatus -> VM -> IWStatusFrame(所有子控件frame 和 IWStatus)
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *s  in statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = s;
            
            [arrM addObject:statusF];
        }
        
        // 提示最新微博数
        [self showNewStatusesCount:statuses.count];
        
        // 停止头部刷新
        [self.tableView headerEndRefreshing];
        
        // 把最新的微博数据插入到微博数组中
        NSRange range = NSMakeRange(0, statuses.count);
        // location : 插入哪个角标
        // len :插入个数:最新微博数组的个数
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        // 用成员变量保存数据
        [self.statusFrameArr insertObjects:arrM atIndexes:indexSet];
        
        // 获取到新数据的时候,刷新表格
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        // 刷新结束
        _isrefreshing = NO;
    }];
}

// 提示最新微博数
- (void)showNewStatusesCount:(NSInteger)count
{

    if (count == 0) return;
//    self.view = self.tableView
    
    CGFloat labelH = 35;
    CGFloat labelY = 64-labelH;
    CGFloat labelW = self.view.width;
    CGFloat labelX = 0;
    
    // 弹出最新微博数控件
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    
    // 设置微博数
    statusLabel.text = [NSString stringWithFormat:@"%ld 条新微博数",count];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    // 把statusLabel插入到导航条下面
    [self.navigationController.view insertSubview:statusLabel belowSubview:self.navigationController.navigationBar];
    
    // 做动画
    CGFloat durtion = 0.25;
    [UIView animateWithDuration:durtion animations:^{
        // 往下移动
        statusLabel.transform = CGAffineTransformMakeTranslation(0, labelH);
    } completion:^(BOOL finished) {
        
        // 延迟1秒,在做动画,往上移动
        [UIView animateWithDuration:durtion delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            
            // 把形变清空
            statusLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 移除导航控制器
            [statusLabel removeFromSuperview];
            
        }];
        
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
    
    // 获取登录用户的信息(名称)
    NSString *name = [IWAccountTool account].name;
    
    // 都需要请求用户,防止以后用户把名称改了
    [IWUserTool userInfoDidSuccess:^(IWUser *user) { // 获取用户成功就会调用这个block
        
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        
    }];


    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
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
    
    return self.statusFrameArr.count;
}


// 返回每个cell长什么样子,一有新的cell出现就会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    IWStatusCell *cell = [IWStatusCell cellWithTable:tableView];
    
    // 传递模型
    IWStatusFrame *sf = self.statusFrameArr[indexPath.row];
    cell.sf = sf;

    return cell;
}

// 点击一行Cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWOneViewController *one = [[IWOneViewController alloc] init];
   
    [self.navigationController pushViewController:one animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWStatusFrame *sf = self.statusFrameArr[indexPath.row];
    return sf.cellH;
}


@end
