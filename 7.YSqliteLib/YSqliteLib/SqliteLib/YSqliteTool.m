//
//  YSqliteTool.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "YSqliteTool.h"
#import "sqlite3.h"

#define kCachePath  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

@implementation YSqliteTool


+ (BOOL)dealSql: (NSString *)sql withUid: (NSString *)uid{
    
    NSString *dbName = @"Common.db";
    if (uid.length != 0) {
        dbName = [NSString stringWithFormat:@"%@.db",uid];
    }
    NSString *dbPath = [kCachePath stringByAppendingPathComponent:dbName];
    
    sqlite3 *ppDb = nil;
    //1.打开/创建一个数据库
    if (sqlite3_open(dbPath.UTF8String, &ppDb) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return NO;
    }
    
    //2.执行语句
    
    BOOL result = sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
    
    //3.关闭数据库
    sqlite3_close(ppDb);
    
    return result;
    
}

@end
