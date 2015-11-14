//
//  IWStatusResult.m
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatusResult.h"
#import "MJExtension.h"
#import "IWStatus.h"
@implementation IWStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[IWStatus class]};
}

@end
