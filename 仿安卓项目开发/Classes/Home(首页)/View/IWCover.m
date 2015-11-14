//
//  IWCover.m
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWCover.h"


@implementation IWCover

- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (_dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3;
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;

    }
}

+ (instancetype)show
{
    IWCover *cover = [[IWCover alloc] initWithFrame:IWKeywindow.bounds];
    
    [IWKeywindow addSubview:cover];
    return cover;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if (_dismissCompletion) {
        _dismissCompletion();
    }
}

@end
