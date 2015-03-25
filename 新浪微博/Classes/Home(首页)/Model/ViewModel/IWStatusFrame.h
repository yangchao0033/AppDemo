//
//  IWStatusFrame.h
//  新浪微博
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWStatus.h"
@interface IWStatusFrame : NSObject

@property (nonatomic, strong) IWStatus *status;

// 计算所有cell子控件的frame
// 原创frame
@property (nonatomic, assign) CGRect originalViewF;
// 转发frame
@property (nonatomic, assign) CGRect retweetViewF;
// 工具条frame
@property (nonatomic, assign) CGRect toolBarF;

// cell的高度
@property (nonatomic, assign) CGFloat cellH;

/* 原创微博所有子控件*/
/**
 *  头像frame
 */
@property (nonatomic, assign) CGRect iconViewF;
/**
 *  昵称frame
 */
@property (nonatomic, assign) CGRect nameViewF;
/**
 *  会员frame
 */
@property (nonatomic, assign) CGRect vipViewF;
/**
 *  时间frame
 */
@property (nonatomic, assign) CGRect timeViewF;
/**
 *  来源frame
 */
@property (nonatomic, assign) CGRect soureceViewF;
/**
 *  内容frame
 */
@property (nonatomic, assign) CGRect textViewF;
/**
 *  配图相册frame
 */
@property (nonatomic, assign) CGRect photosViewF;

/* 转发微博所有子控件*/
/**
 *  转发昵称frame
 */
@property (nonatomic, assign) CGRect retweetNameViewF;

/**
 *  转发微博内容frame
 */
@property (nonatomic, assign) CGRect retWeetTextViewF;
/**
 *  转发配图相册frame
 */
@property (nonatomic, assign) CGRect retWeetphotosViewF;

@end
