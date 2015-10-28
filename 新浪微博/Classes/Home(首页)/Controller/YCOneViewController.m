//
//  YCOneViewController.m
//  微博项目
//
//  Created by yc on 15-4-10.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "YCOneViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface YCOneViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *QR_border;
@property (weak, nonatomic) IBOutlet UIView *ScanView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstrain;
// -290,最大为12 + 290
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;
@property (weak, nonatomic) IBOutlet UIImageView *moveIcon;
@property (nonatomic, strong)CADisplayLink *link;
@property (nonatomic, strong)AVCaptureSession *session;
@property (nonatomic, assign)CGAffineTransform scanTransform;

@end

@implementation YCOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置定时器
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(move)];
    self.link = link;
    [self setAV];
    self.scanTransform = self.ScanView.transform;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qrcode_tabbar_background"]];
}
- (void)setAV
{
    // 1.获取输入设备(摄像头)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2.根据输入设备创建输入对象
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    
    if (input == nil) {
        return;
    }
    
    // 3.创建输出对象
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 4.设置代理监听输出对象输出的数据
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 5.创建会话(桥梁)
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 6.添加输入和输出到会话中
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
#warning 注意: 设置输出对象能够解析的类型必须在输出对象添加到会话之后设置, 否则会报错
    // 7.告诉输出对象, 需要输出什么样的数据(支持解析什么样的🐴)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeUPCECode,
                                     AVMetadataObjectTypeCode39Code,
                                     AVMetadataObjectTypeCode39Mod43Code,
                                     AVMetadataObjectTypeEAN13Code,
                                     AVMetadataObjectTypeEAN8Code,
                                     AVMetadataObjectTypeCode93Code,
                                     AVMetadataObjectTypeCode128Code,
                                     AVMetadataObjectTypePDF417Code,
                                     AVMetadataObjectTypeQRCode,
                                     AVMetadataObjectTypeAztecCode,
                                     AVMetadataObjectTypeInterleaved2of5Code,
                                     AVMetadataObjectTypeITF14Code,
                                     AVMetadataObjectTypeDataMatrixCode
                                     ]];
   
    // 8.创建预览图层
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    
    // 8.开始扫描数据
#warning 注意: 扫描二维码是一个持久的操作, 也就是很耗时.
    
    self.session = session;
}
- (void)move
{
//    DDLogInfo(@"%s", __func__);
    self.topSpace.constant +=3;
    if (self.topSpace.constant >= 240) {
        self.topSpace.constant = -290;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topSpace.constant = 0;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self.session startRunning];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self.session stopRunning];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    //    DDLogInfo(@"%s", __func__);
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        self.link.paused = YES;
        NSString *result = [[metadataObjects lastObject] stringValue];
//        DDLogInfo(@"%@", result);
        // 开启弹框
        NSString *title = [@"是否打开该页面:" stringByAppendingString:result];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"跳转提示,是否打开该页面？"
                                                        message:result delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)QRClick:(UIButton *)sender {
    [self changeScanFrameWithW:200 H:200 completion:^(BOOL finished) {
        if (finished) {
            self.moveIcon.image = [UIImage imageNamed:@"qrcode_scanline_barcode"];
            self.QR_border.image = [UIImage imageNamed:@"qrcode_border"];            
        }
    }];
    self.navigationItem.title = @"二维码";
    
}
- (IBAction)BarClick:(UIButton *)sender {

    [self changeScanFrameWithW:250 H:150 completion:^(BOOL finished) {
        if (finished) {
            self.moveIcon.image = [UIImage imageNamed:@"qrcode_scanline_barcode"];
            self.QR_border.image = [UIImage imageNamed:@"qrcode_border"];
        }
    }];
    self.navigationItem.title = @"条形码";
}

- (void)changeScanFrameWithW:(CGFloat)width H:(CGFloat)height completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.5 animations:^{
        self.widthConstrain.constant = width;
        self.heightConstrain.constant = height;
        [self.view layoutIfNeeded];
//        [self.ScanView layoutIfNeeded];
    } completion:completion];

}



#pragma mark alert代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    DDLogInfo(@"%tu", buttonIndex);
    if (buttonIndex == 0) {
        self.link.paused = NO;
        [self.session startRunning];
    } else {
//        DDLogInfo(@"打开%@", alertView.message);
    }
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
