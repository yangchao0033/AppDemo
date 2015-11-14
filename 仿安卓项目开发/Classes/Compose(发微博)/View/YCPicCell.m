//
//  YCPicCell.m
//  新浪微博
//
//  Created by yc on 15-4-19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YCPicCell.h"


@interface YCPicCell ()
@property (weak, nonatomic) IBOutlet UIButton *bigImg;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@end
@implementation YCPicCell

+ (NSString *)identifier
{
    return @"picCell";
}
- (IBAction)BigImgBtn:(UIButton *)sender {
    NSLog(@"%tu -----%tu", self.path.item, _photosCount);
    if (self.path.item == _photosCount) {
        // 投递大图通知
        [[NSNotificationCenter defaultCenter] postNotificationName:YC_DID_ADD_PIC object:self];        
    }
}
- (IBAction)deleteClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:YC_DID_DELETE_PIC object:self];
}

- (void)setImage:(UIImage *)image
{
    // 处理重用
    if (image == nil) {
        // 设置删除按钮的显示状态
        self.deleteBtn.hidden = YES;
        // 设置为加号图片
        [self.bigImg setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:(UIControlStateNormal)];
        [self.bigImg setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:(UIControlStateNormal)];
    } else {
        self.deleteBtn.hidden = NO;
        // 设置为参数图片
        [self.bigImg setBackgroundImage:image forState:(UIControlStateNormal)];
    }
}

@end
