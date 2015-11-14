//
//  IWStausPictureController.m
//  新浪微博
//
//  Created by yc on 15-4-17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "IWStausPictureController.h"
#import "YCPicCell.h"
#define photoCount 9

@interface IWStausPictureController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;

@end

@implementation IWStausPictureController

static NSString * const reuseIdentifier = @"picCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置浏览器的宽高间距
    CGFloat margin = 5;
    int col = 3;
    CGFloat cellWidth = ([UIScreen mainScreen].bounds.size.width - (col + 1) * margin) / col;
    self.collectionLayout.itemSize = CGSizeMake(cellWidth, cellWidth);
    self.collectionLayout.minimumLineSpacing = margin;
//    self.collectionLayout.
    self.collectionLayout.minimumInteritemSpacing = margin;
    self.collectionLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    // 订阅删除和添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deletePhoto:) name:YC_DID_DELETE_PIC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPhoto:) name:YC_DID_ADD_PIC object:nil];
}

// 处理添加
- (void)addPhoto:(NSNotification *)no
{
    // 打开相册
    UIImagePickerController *photo = [[UIImagePickerController alloc] init];
    photo.delegate = self;
    [self presentViewController:photo animated:YES completion:nil];
    NSLog(@"%s", __func__);
}
// 处理删除
- (void)deletePhoto:(NSNotification *)no
{
    // 将传过来的cell的path，从数组中删除并刷新数据
    YCPicCell *cell = no.object;
    NSIndexPath *path = cell.path;
    [self.photos removeObjectAtIndex:path.item];
    [self.collectionView reloadData];
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 图片浏览器代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSLog(@"%@", info);
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.photos.count >= photoCount) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"发送图片超过%d张", photoCount]];
        return;
    }
    [self.photos addObject:image];
    [self.collectionView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return self.photos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.path = indexPath;
    cell.photosCount = self.photos.count;
    if (indexPath.item == self.photos.count) {
        cell.image = nil;
    } else {
        cell.image = self.photos[indexPath.item];
        // 指定当前返回的cell路径，否则删除的时候不知道删除哪个
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
#pragma mark lasy
- (NSMutableArray *)photos
{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc] initWithCapacity:4];
    }
    return _photos;
}
@end
