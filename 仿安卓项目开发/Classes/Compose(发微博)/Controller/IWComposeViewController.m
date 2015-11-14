//
//  IWComposeViewController.m
//  新浪微博
//
//  Created by apple on 14/11/29.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
#import "YCHTTPManager.h"
#import "IWComposeViewController.h"
#import "IWTextView.h"
#import "IWComposeBar.h"
#import "IWComposePhotosView.h"
#import "MBProgressHUD+MJ.h"
#import "IWStausPictureController.h"
#import "YCTextView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HMEmoticonsController.h"
#import "IWComposeTool.h"
#import "HMEmoticon.h"
#import <JDStatusBarNotification/JDStatusBarNotification.h>

// UITextViewDelegate继承UIScrollViewDelegate
@interface IWComposeViewController ()<UITextViewDelegate,IWComposeBarDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate,EmoticonsControllerDelegate>

@property (nonatomic, weak) UIBarButtonItem *right;
@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, weak) IWComposeBar *composeBar;
@property (nonatomic, weak) IWComposePhotosView *photosView;
// 自定义输入框
@property (weak, nonatomic) IBOutlet YCTextView *costumTextView;
// 自定义工具条
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarButtom;
// 自定义表情键盘
@property (nonatomic, weak) HMEmoticonsController *emoticonsVC;
// 为图片控制器延长生命周期
@property (nonatomic, strong) IWStausPictureController *statusPictureVC;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendBtn;
@property (nonatomic, assign, getter=isSending) BOOL sending;
@end

@implementation IWComposeViewController

/**
 *  1、实现按钮点击功能
    2、实现工具条的点击功能，并切换自定义键盘
    3、监听文本框的字数，大于零时就
    4、当文板框滚动时注销第一响应者
    5、当键盘确实改变时改变工具条的约束
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sending = NO;
    self.sendBtn.enabled = NO;
    
    [self setRightNavBarItem];
    // 自定义状态栏通知
    [JDStatusBarNotification addStyleNamed:JDStatusBarStyleDark
                                   prepare:^JDStatusBarStyle*(JDStatusBarStyle *style) {
                                       
                                       // main properties
                                       style.barColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
                                       style.textColor = [UIColor whiteColor];
                                       return style;
                                   }];
}

- (void)setRightNavBarItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    // 设置正常状态下的颜色
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _right = right;
    right.enabled = NO;
    self.navigationItem.rightBarButtonItem = right;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 注册通知监听键盘改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardTrueDidChanged:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardTrueDidChanged:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.costumTextView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = (textView.text.length > 0);
}
// 监听140以外不能发送
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    NSLog(@"%@ %@", NSStringFromRange(range), text);
    // 1.获取已经显示的文本长度
    NSUInteger oldLength = self.costumTextView.fullTextStr.length;
    // 2.获取当前需要追加的文本长度
    NSUInteger newLength = text.length;
    
    if ((oldLength + newLength) > 140) {
        return NO;
    }
    return YES;
}
// 通知监听键盘改变
- (void)keyBoardTrueDidChanged:(NSNotification *)no
{
//    NSLog(@"%@", no);
//    NSLog(@"%@", no.userInfo);
    // 获取动画时间和节奏
    NSUInteger cave = 0;
    CGFloat duration = 0;
    CGFloat height = 0.0;
    cave = [no.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    duration = [no.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if ([no.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect tempR = [no.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        height = tempR.size.height;
    }
    self.toolbarButtom.constant = height;
    [UIView animateWithDuration:duration delay:0 options:cave<<16 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}


// 监听导航栏点击事件
- (IBAction)cancle:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 发送微博事件
- (IBAction)send:(UIBarButtonItem *)sender {
    if (self.isSending == NO) {
        self.sending = YES;
        // 设置状态栏提示
        [JDStatusBarNotification showWithStatus:@"准备发送" styleName:JDStatusBarStyleDark];
        [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        
        __weak typeof(self) weakSelf = self;
        YCHTTPManager *manager = [YCHTTPManager sharedManager];
        if (self.statusPictureVC.photos.count > 0) {
            UIImage *image = [self.statusPictureVC.photos firstObject];
            [manager sendStatusWithText:self.costumTextView.fullTextStr image:image success:^(IWStatus *status) {
//                [JDStatusBarNotification dismissAnimated:YES];
                [JDStatusBarNotification showWithStatus:@"发送成功" dismissAfter:2 styleName:JDStatusBarStyleDark];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                weakSelf.sending = NO;
            } failure:^(NSError *error) {
                [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:3 styleName:JDStatusBarStyleDark];
                weakSelf.sending = NO;
            }];
        } else {
            [manager sendStatusWithText:self.costumTextView.fullTextStr success:^(IWStatus *status) {
//                [JDStatusBarNotification dismissAnimated:YES];
                [JDStatusBarNotification showWithStatus:@"发送成功" dismissAfter:2 styleName:JDStatusBarStyleDark];
                weakSelf.sending = NO;
                NSLog(@"发送成功");
                [weakSelf cancle:nil];
            } failure:^(NSError *error) {
                weakSelf.sending = NO;
//                [SVProgressHUD showErrorWithStatus:@"发送失败" maskType:(SVProgressHUDMaskTypeBlack)];
                [JDStatusBarNotification showWithStatus:@"发送失败" dismissAfter:3 styleName:JDStatusBarStyleDark];
                NSLog(@"发送失败");
            }];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"正在发送。。。请稍后" maskType:(SVProgressHUDMaskTypeBlack)];
    }
    NSLog(@"%s", __func__);
    // 使用网络工具类进行网络通讯
}

// 获取内嵌的图片collectionview控制器
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.statusPictureVC = segue.destinationViewController;
}

#pragma mark - 表情键盘
- (IBAction)selectEmoticonBtn:(UIButton *)sender
{
    // 1.关闭系统自带键盘
    [self.costumTextView resignFirstResponder];
    
    // 2.切换键盘
    if (self.costumTextView.inputView == nil) {
        self.costumTextView.inputView = self.emoticonsVC.view;
    }else{
        // 只要inputView是nil, 那么就会自动召唤出系统自带的键盘
        self.costumTextView.inputView = nil;
    }
    
    // 3.重新成为第一响应者
    [self.costumTextView becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emoticonsController:(HMEmoticonsController *)emoticonsController emoticon:(HMEmoticon *)emoticon
{
    
    // -2监听删除按钮的点击
    if (emoticon.isDeleteButton) {
        // 点击了删除按钮
        [self.costumTextView deleteBackward];
    }
    
    // -1获取即将要修改的内容
    NSString *temp = nil;
    if (emoticon.emoji != nil) {
        temp = emoticon.emoji;
    }else if (emoticon.chs != nil)
    {
        temp = emoticon.chs;
    }
    if (temp == nil) {
        return;
    }
    
    // 0. 如果是输入表情, 那么自己手动调用shouldChangeTextInRange
    if([self textView:self.costumTextView shouldChangeTextInRange:self.costumTextView.selectedRange replacementText:temp]){
        if (emoticon.emoji != nil) {
            // emoji表情
            // 将指定字符串替换到光标选中的位置
            [self.costumTextView replaceRange:self.costumTextView.selectedTextRange withText:emoticon.emoji];
            // 注意: 添加emoji表情不会触发 shouldChangeTextInRange
            // 但是会触发 : textViewDidChange
        }else if (emoticon.chs != nil) {
            // 1.自定义表情
            [self.costumTextView setEmoticonStr:emoticon];
            // 2.自己手动发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.costumTextView];
            // 3.自己主动调用textdidichange方法
            [self textViewDidChange:self.costumTextView];
            // 注意: 添加自定义表情不会触发shouldChangeTextInRange和textViewDidChange
        }
    }
    
}

#pragma mark - lazy
- (HMEmoticonsController *)emoticonsVC
{
    if (!_emoticonsVC) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HMEmoticonsController" bundle:nil];
        _emoticonsVC = sb.instantiateInitialViewController;
        _emoticonsVC.delegate = self;
    }
    return _emoticonsVC;
}

@end
