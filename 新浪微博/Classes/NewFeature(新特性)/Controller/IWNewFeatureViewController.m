//
//  IWNewFeatureViewController.m
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWNewFeatureViewController.h"
#import "IWNewFeatureCell.h"
#define IWImageCount 4
@interface IWNewFeatureViewController ()
@property (nonatomic, weak) UIPageControl *padgeControl;
@end

@implementation IWNewFeatureViewController

static NSString *ID = @"cell";

- (instancetype)init
{
    
    // 创建布局参数
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置item的尺寸
    layout.itemSize = IWScreenSizes.size;
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 0;
    
    return [self initWithCollectionViewLayout:layout];
}
// self.view != self.collectionView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor redColor];
    
    // 注册UICollectionViewCell
    [self.collectionView registerClass:[IWNewFeatureCell class] forCellWithReuseIdentifier:ID];

    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageControll
    [self setUpPageControl];
    
}

#pragma mark -添加pageControl
- (void)setUpPageControl
{
    UIPageControl *padgeControl = [[UIPageControl alloc] init];
    padgeControl.numberOfPages = IWImageCount;
    padgeControl.currentPageIndicatorTintColor = [UIColor redColor];
    padgeControl.pageIndicatorTintColor = [UIColor blackColor];
    padgeControl.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _padgeControl = padgeControl;
    [self.view addSubview:padgeControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    int page = scrollView.contentOffset.x / scrollView.width + 0.5;
    
    _padgeControl.currentPage = page;
}

#pragma mark <UICollectionViewDataSource>


// 返回一组有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return IWImageCount;
}

// 返回每个cell的样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    IWNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",indexPath.item + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath itemCount:IWImageCount];
    
    return cell;
}



@end
