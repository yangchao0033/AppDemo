//
//  IWComposeViewController.m
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWComposeViewController.h"
#import "IWTextView.h"
#import "IWComposeBar.h"
#import "IWComposePhotosView.h"
#import "MBProgressHUD+MJ.h"


#import "IWComposeTool.h"

// UITextViewDelegate继承UIScrollViewDelegate
@interface IWComposeViewController ()<UITextViewDelegate,IWComposeBarDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIBarButtonItem *right;
@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, weak) IWComposeBar *composeBar;
@property (nonatomic, weak) IWComposePhotosView *photosView;



@end

@implementation IWComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航条的内容
    [self setUpNavBar];
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpComposeBar];
    
    // 只要系统的键盘一出现就会发送通知
    // UIKeyboardWillShowNotification监听键盘即将弹出的时候
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    // UIKeyboardWillHideNotification监听键盘即将隐藏的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:UIKeyboardWillHideNotification object:nil];
}

// 键盘弹出的时候调用
- (void)showKeyboard:(NSNotification *)notification
{
    // 把对象转换成CGRect结构体
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _composeBar.transform = CGAffineTransformMakeTranslation(0, -rect.size.height);
}
// 键盘隐藏的时候调用
- (void)hideKeyboard
{
    // 清空形变
    _composeBar.transform = CGAffineTransformIdentity;
}
- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setUpComposeBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    IWComposeBar *composeBar = [[IWComposeBar alloc] initWithFrame:CGRectMake(x, y, w, h)];
    composeBar.delegate = self;
    _composeBar = composeBar;
    [self.view addSubview:composeBar];
}

// 点击工具条下面的按钮就会调用
- (void)composeBar:(IWComposeBar *)bar didClickBtn:(IWComposeBarButtonStyle)style
{
    switch (style) {
        case IWComposeBarButtonStylePicture: // 相册
        {
            // 弹出相册
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            // 设置相册的数据源
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }
            break;
        case IWComposeBarButtonStyleEmoticon: // 表情
        {
            // 弹出表情键盘
            
        }
            break;
        default:
            break;
    }
}

// 当在系统相册里选择完一张图片的时候就会调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取选中图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 把选中的图片添加到相册上
    [_photosView addImage:image];
    
    _right.enabled = YES;
    
    // 永远都是隐藏最上面Modal出来控制器
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)setUpNavBar
{
    self.title = @"发送微博";
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    // 设置正常状态下的颜色
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _right = right;
    right.enabled = NO;
    self.navigationItem.rightBarButtonItem = right;
}

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击发送按钮调用
- (void)send
{
    
    if (_photosView.images.count) { // 发送图片
        // 注意新浪接口并没有开放多张图片上传,只能上传一张
        [self composeImage];
    }else{ // 发送文字微博
        [self composeText];
    }
    
   
}
// 发送微博图片
- (void)composeImage
{
    UIImage *image = [_photosView.images firstObject];
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    [MBProgressHUD showMessage:@"正在发送微博...."];

    [IWComposeTool composeWithImage:image status:status success:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
        [self cancle];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [self cancle];
        [MBProgressHUD showError:@"发送失败"];
    }];
}
// 发送微博文字
- (void)composeText
{
    [MBProgressHUD showMessage:@"正在发送微博...."];
    
    [IWComposeTool composeWithStatus:_textView.text success:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
        [self cancle];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [self cancle];
        [MBProgressHUD showError:@"发送失败"];
    }];
}
- (void)textViewDidChange:(UITextView *)textView
{
    _textView.hidePlaceHolder = _textView.text.length;
    _right.enabled =  _textView.text.length;

}
- (void)setUpTextView
{

    IWTextView *textView = [[IWTextView alloc] initWithFrame:self.view.bounds];
    // 设置delegate想当与设置UIScrollView的代理
    textView.delegate = self;
    // 设置垂直有弹性->可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享新鲜shi....";
    [self.view addSubview:textView];
    _textView = textView;
    
    // 添加相册view
    IWComposePhotosView *photosView = [[IWComposePhotosView alloc] initWithFrame:self.view.bounds];
    photosView.y = 70;
    _photosView = photosView;
    [_textView addSubview:photosView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}


@end
