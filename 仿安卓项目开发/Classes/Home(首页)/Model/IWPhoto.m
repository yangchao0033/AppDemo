//
//  IWPhoto.m
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWPhoto.h"

@implementation IWPhoto

- (void)setThumbnail_pic:(NSURL *)thumbnail_pic
{
    
    NSString *urlStr = thumbnail_pic.absoluteString;
   urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    
    _thumbnail_pic = [NSURL URLWithString:urlStr];
}
@end
