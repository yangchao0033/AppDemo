//
//  YCMyCodeController.m
//  微博项目
//
//  Created by yc on 15-4-10.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "YCMyCodeController.h"
#import <CoreImage/CoreImage.h>


@interface YCMyCodeController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation YCMyCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupIcon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupIcon
{
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.还原滤镜初始化属性
    [filter setDefaults];
    // 3.将需要生成二维码的数据转换成二进制
    NSData *data = [@"http://weibo.com/3266043817/profile?topnav=1&wvr=6"  dataUsingEncoding:NSUTF8StringEncoding];
    // 4.给二维码滤镜设置数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 5.获取滤镜生成的图片
    CIImage *ciImage =  [filter outputImage];
    UIImage *bgImage = [self createNonInterpolatedUIImageFormCIImage:ciImage withSize:200];
    
    UIImage *iconImage = [UIImage imageNamed:@"icon"];
    UIImage *newImage = [self createNewImageWithBg:bgImage icon:iconImage];
    
    // 6.设置图片到控件上
    self.icon.image = newImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
/**
 *  给现有图片添加水印
 *
 *  @param bgImage 背景图片
 *  @param icon    水印图片
 *
 *  @return 加好水印的新图片
 */
- (UIImage *)createNewImageWithBg:(UIImage *)bgImage icon:(UIImage *)icon{
    // 1.开启图片上下文
    UIGraphicsBeginImageContext(bgImage.size);
    
    // 2.绘制背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.绘制图标
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    CGFloat iconX = (bgImage.size.width - iconW) * 0.5;
    CGFloat iconY = (bgImage.size.height - iconH) * 0.5;
    [icon drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    // 4.取出绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    // 6.返回生成好得图片
    return newImage;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
