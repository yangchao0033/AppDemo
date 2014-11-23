//
//  IWSearchBar.m
//  新浪微博
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSearchBar.h"

@implementation IWSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置UITextField边框样式
        self.background = [UIImage resizableImageWithName:@"searchbar_textfield_background"];
        self.clearButtonMode = UITextFieldViewModeAlways;
        

        self.font = [UIFont systemFontOfSize:12];
        
        // 设置左边放大镜
        // 默认UIImageView的尺寸跟图片一样
        UIImageView *leftV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        // 把leftView的宽度拉伸
        leftV.width += 10;
        
        // 设置leftV内容模式居中
        leftV.contentMode = UIViewContentModeCenter;
        
        // 如果要显示左边视图,必须设置leftViewMode
        self.leftView = leftV;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}


@end
