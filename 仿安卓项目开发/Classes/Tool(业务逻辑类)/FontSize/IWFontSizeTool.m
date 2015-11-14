//
//  IWFontSizeTool.m
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWFontSizeTool.h"
#define IWUserDefaults [NSUserDefaults standardUserDefaults]
#define IWFontSizeKey @"fontSizeKey"
@implementation IWFontSizeTool

+ (void)saveFontSize:(NSString *)fontSize
{
    [IWUserDefaults setObject:fontSize forKey:IWFontSizeKey];
    [IWUserDefaults synchronize];
}

+ (NSString *)fontSize
{
    return [IWUserDefaults objectForKey:IWFontSizeKey];
}

@end
