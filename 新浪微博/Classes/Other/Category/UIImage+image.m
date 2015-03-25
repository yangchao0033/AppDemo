//
//  UIImage+image.m
//  新浪微博
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)
+ (UIImage *)resizableImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
