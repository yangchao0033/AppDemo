//
//  IWLoadFailedViewController.m
//  新浪微博
//
//  Created by yc on 15-3-29.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "IWLoadFailedViewController.h"

@interface IWLoadFailedViewController ()


@end

@implementation IWLoadFailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)refreshLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:YCLoginRefresh object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
