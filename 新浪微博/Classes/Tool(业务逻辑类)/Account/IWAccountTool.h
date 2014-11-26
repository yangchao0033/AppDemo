//
//  IWAccountTool.h
//  新浪微博
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWAccount;
@interface IWAccountTool : NSObject


+ (void)save:(IWAccount *)account;
+ (IWAccount *)account;

@end
