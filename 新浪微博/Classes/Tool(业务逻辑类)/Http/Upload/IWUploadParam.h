//
//  IWUploadParam.h
//  新浪微博
//
//  Created by apple on 14/11/30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUploadParam : NSObject

/**
 *  Data:要拼接文件的二进制数据,image -> data
 */
@property (nonatomic, strong) NSData *data;
/**
 *  paramName:参数名称,拼接的二进制数据属于哪个参数
 */
@property (nonatomic, copy) NSString *paramName;
/**
 *  fileName:文件名称,上传到服务器显示的名称
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  mimeType:文件格式,通过这个格式,服务器就知道需要把二进制数据转换成什么文件
 */
@property (nonatomic, copy) NSString *mimeType;


@end
