//
//  IWDiscoverViewController.m
//  新浪微博
//
//  Created by apple on 14-11-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWDiscoverViewController.h"
#import "IWSearchBar.h"

@interface IWDiscoverViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation IWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSearch];
//    [self setTimer];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTimer];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)setSearch
{
    IWSearchBar *searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 35)];
    
    // 设置占位符
    searchBar.placeholder = @"大家都在搜";
    
    searchBar.delegate = self;
    
    self.navigationItem.titleView = searchBar;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

- (void)setTimer
{
    // 1、循环添加图片
    int pageNum = 5;
    CGFloat imgViewY = 0;
//    CGFloat imgViewW = self.scrollView.frame.size.width;
    CGFloat imgViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat imgViewH = self.scrollView.frame.size.height;
    for (int i = 0; i < pageNum; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"img_0%d", i + 1]]];
        CGFloat imgViewX = i * imgViewW;
        
        imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
        
        [self.scrollView addSubview:imgView];
    }
    // 2、设置scrollView属性
    self.scrollView.contentSize = CGSizeMake(pageNum * imgViewW, imgViewH);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    // 2.1、设置换页控件页数
    self.pageControl.numberOfPages = pageNum;
    // 3、配置定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    // 4、回传属性
    _timer = timer;
}



- (void)nextImage
{
    // 从当前页控制器获取索引更安全，索引会随着页面变换变换
    int pageIndex = (int)_pageControl.currentPage;
    
    if (pageIndex == self.pageControl.numberOfPages - 1) {
        pageIndex = 0;
    } else {
        pageIndex++;
    }
    CGFloat offSetW = self.scrollView.frame.size.width;
    // 设置带动画的偏移量
    [self.scrollView setContentOffset:CGPointMake(pageIndex * offSetW, 0) animated:YES];
    //    self.scrollView.contentOffset = CGPointMake(pageIndex * offSetW, 0);
}

#pragma mark 代理方法
// 利用该方法调整_pageControl.currentPage
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + 0.5 * scrollView.frame.size.width) / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

// 利用该方法在拖拽时卸载计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

// 利用该方法在拖拽后重新安装计时器以及循环器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}


@end
