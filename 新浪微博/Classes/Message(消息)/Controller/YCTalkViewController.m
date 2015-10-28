//
//  ViewController.m
//  002QQ聊天20150127
//
//  Created by teacher on 15/1/27.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YCTalkViewController.h"
#import "HMMessage.h"
#import "HMMessageFrame.h"
#import "HMMessageCell.h"
#import "IWHttpTool.h"
#import "AFNetworking.h"
#import <JDStatusBarNotification/JDStatusBarNotification.h>

@interface YCTalkViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSURLSessionTaskDelegate>

// 带frame的模型
@property (nonatomic, strong) NSMutableArray *messages;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *txtSend;

@property (strong, nonatomic) NSDictionary *autoMessages;

@end

@implementation YCTalkViewController

#pragma mark - /************** 懒加载数据 **************/
- (NSMutableArray *)messages
{
    if (_messages == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict) {
            
            // 新的
            // 数据模型
            HMMessage *model = [HMMessage messageWithDict:dict];
            // frame模型
            HMMessageFrame *frameModel = [[HMMessageFrame alloc] init];
            
            
            
            // 上一条的
            // 获取上一条数据的frame模型
            HMMessageFrame *lastModelFrame =  [arrayModels lastObject];
            // 获取上一条数据的数据模型
            HMMessage *lastModel = lastModelFrame.message;
            
            
            // 根据新的模型与上一条模型进行计算, 计算出新模型是否需要隐藏时间Label
            // 判断上一条数据的时间是否与当前数据的时间相等
            if ([lastModel.time isEqualToString:model.time]) {
                frameModel.hideTime = YES;
            } else {
                frameModel.hideTime = NO;
            }
            
            
            // 把新的数据模型与新的frame相关联
            frameModel.message = model;
            
            
            
            [arrayModels addObject:frameModel];
        }
        
        _messages = arrayModels;
    }
    return _messages;
}

- (NSDictionary *)autoMessages
{
    if (_autoMessages == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"autoMessages.plist" ofType:nil];
        _autoMessages = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _autoMessages;
}






#pragma mark - /************** 数据源方法 **************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (void)cellDidSelectedAndComplitionWith:(void (^)(UIImageView *))block
{
    self.displayIconBlock = block;
}
// 聊天页面
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取模型数据(带frame的模型)
    HMMessageFrame *modelFrame = self.messages[indexPath.row];
    
    
    // 2. 创建单元格
    
    HMMessageCell *cell = [HMMessageCell messageCellWithTableView:tableView];
    cell.displayIconBlock = self.displayIconBlock;
    // 3. 为单元格设置数据
    cell.messageFrame = modelFrame;
    
    return cell;
    
}




#pragma mark - /************** UITableView的代理方法 **************/
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取模型数据(带frame的模型)
    HMMessageFrame *modelFrame = self.messages[indexPath.row];
    return modelFrame.cellHeight;
}



#pragma mark - /************** 文本框的代理方法 **************/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


// 当点击return(send)键的时候执行下面的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 这里就是当用户点击了"Send"以后要执行的代码
   // 1. 获取用户输入的数据
    NSString *userInput = textField.text;
    [self sendMessage:userInput type:HMMessageTypeMe];
    
    
    // 2. 系统回消息
    NSString *messageUrl = [[NSString stringWithFormat:@"http://www.tuling123.com/openapi/api?key=6c2cfaf7a7f088e843b550b0c5b89c26&&info=%@", userInput] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    [manager GET:messageUrl  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *backMessage = responseObject[@"text"];
        [weakSelf sendMessage:backMessage type:HMMessageTypeOther];
//        [JDStatusBarNotification showWithStatus:@"发送成功" dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [JDStatusBarNotification showWithStatus:@"接收失败" dismissAfter:1.0 styleName:JDStatusBarStyleError];
    }];


    self.txtSend.text = nil;
    return YES;
}


// 封装一个发送消息的方法
- (void)sendMessage:(NSString *)msg type:(HMMessageType)type
{
    // 2. 创建新的模型数据加到self.messages中
    // 2.1 创建一个数据模型
    HMMessage *model = [[HMMessage alloc] init];
    // 设置消息类型
    model.type = type;
    // 消息正文
    model.text = msg;
    // 设置发送时间
    NSDate *nowDate = [NSDate date];
    // 获取一个日期时间转换器(可以把日期对象转换为字符串, 也可以把字符串转换为日期对象)
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置你要的日期的格式
    //yyyy-MM-dd hh(HH):mm:ss
    formatter.dateFormat = @"今天HH:mm";
    // 进行格式化
    NSString *dateStr = [formatter stringFromDate:nowDate];
    model.time = dateStr;
    
    
    
    // 创建一个frame模型
    HMMessageFrame *frameModel = [[HMMessageFrame alloc] init];
    frameModel.message = model;
    
    // 设置是否需要隐藏时间
    HMMessage *lastMessage = (HMMessage *)[[self.messages lastObject] message];
    if ([model.time isEqualToString:lastMessage.time]) {
        frameModel.hideTime = YES;
    } else {
        frameModel.hideTime = NO;
    }
    
    
    // 把模型加到messages数组中
    [self.messages addObject:frameModel];
    
    // 3. 刷新UITableView
    [self.tableView reloadData];
    
    // 4. 设置最后一行滚动到顶部
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}




#pragma mark - /************** 隐藏状态栏 **************/
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<消息" style:(UIBarButtonItemStyleBordered) target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
//    self.navigationItem.title = @"老王";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:(UIBarButtonItemStyleBordered) target:nil action:nil];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blueColor];
    // 设置tableView的背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    // 去掉单元格的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 不允许行被选中
    self.tableView.allowsSelection = NO;
    
    // 设置文本框左边的"填充"
    UIView *leftVw = [[UIView alloc] init];
    leftVw.frame = CGRectMake(0, 0, 10, 1);
    self.txtSend.leftView = leftVw;
    self.txtSend.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    // 监听键盘的一些事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 监听通知
    // 监听键盘的frame发生改变的事件
    [center addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    // 为文本框设置代理
    self.txtSend.delegate = self;

}



- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    // 获取键盘事件执行完毕以后的y值
    CGRect keyboardFrame =  [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取当前键盘的Y值
    CGFloat currentY = keyboardFrame.origin.y;
    
    // 计算本次需要平移的距离
    CGFloat transformValue = currentY - [UIScreen mainScreen].bounds.size.height;
    
    // 平移UITableView
    self.view.transform = CGAffineTransformMakeTranslation(0, transformValue);
    
    
    // 让UITableView滚动到最后一行
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
