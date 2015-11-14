//
//  IWOneViewController.m
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWOneViewController.h"
#import "IWTwoViewController.h"

@implementation IWOneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    
}


// 点击按钮做调整
- (IBAction)jump2Two:(id)sender {
    IWTwoViewController *two = [[IWTwoViewController alloc] init];
    
    [self.navigationController pushViewController:two animated:YES];
}

@end
