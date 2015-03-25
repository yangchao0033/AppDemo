//
//  IWUnReadResult.m
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWUnReadResult.h"

@implementation IWUnReadResult

- (int)messageCount{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
   return  self.messageCount + _status + _follower;
}

@end
