//
//  IWUnReadResult.h
//  新浪微博
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 */
@interface IWUnReadResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  所有消息界面未读数
 *
 */
- (int)messageCount;

/**
 *  所有的未读数
 *
 */
- (int)totalCount;

@end
