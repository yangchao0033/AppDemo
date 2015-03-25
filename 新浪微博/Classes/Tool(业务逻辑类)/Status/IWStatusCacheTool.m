//
//  IWStatusCacheTool.m
//  新浪微博
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWStatusCacheTool.h"
#import "FMDB.h"
#import "IWStatus.h"
#import "MJExtension.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWStatusParam.h"

/*
    离线缓存的步骤:
    1.得知道存储什么数据,表名t_status
    2.设计表的字段 存储微博数据,微博模型->dict->二进制,数据->当前用户数据
    前段设计数据库表思路:1.明确需要存储哪个模型,添加一个模型字典字段,存储所有模型的二进制数据2.其他字段的设计参照请求参数
    id dict:字典模型的二进制数据 idstr access_token
    3.创建数据库
    4.创建表格
    5.插入数据
 */

@implementation IWStatusCacheTool
static FMDatabase *_db;
+ (void)initialize
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"status.sqlite"];
    
    // 1.创建FMDatabase对象
    _db = [FMDatabase databaseWithPath:filePath];
    
    // 2.打开数据库
    BOOL success = [_db open];
    if (success) {
        NSLog(@"打开成功");
        
        // 创建表格
      BOOL success1 =  [_db executeUpdate:@"create table if not exists t_status (id integer primary key,dict blob not null,idstr text not null,access_token text not null)"];
        if (success1) {
            NSLog(@"创建表格成功");
        }else{
            NSLog(@"创建表格失败");
        }
        
    }else{
        NSLog(@"打开失败");
    }
}

+ (void)saveStatuses:(NSArray *)statuses
{
    for (IWStatus *status in statuses) {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status.keyValues];
        NSString *accessToken = [IWAccountTool account].access_token;
        NSString *idstr = status.idstr;
        
        
        // 插入数据
        BOOL success =  [_db executeUpdate:@"insert into t_status (dict,access_token,idstr) values(?,?,?)",data,accessToken,idstr];
        if (success) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }

        
    }
    
}

+ (NSArray *)statusesWithParam:(IWStatusParam *)param
{
    NSMutableArray *arrM = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20",param.access_token];
    
    if (param.since_id) {
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20",param.access_token,param.since_id];
    }else if (param.max_id){
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20",param.access_token,param.max_id];
    }
    
   FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        IWStatus *s = [IWStatus objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    return arrM;
}

@end
