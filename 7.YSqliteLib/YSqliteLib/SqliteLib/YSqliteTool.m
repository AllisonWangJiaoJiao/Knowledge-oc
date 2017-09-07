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

static sqlite3 *_ppDb;

+ (BOOL)dealSql: (NSString *)sql withUid: (NSString *)uid{
    
    if (! [self openDBWithUID:uid]) {
        NSLog(@"打开失败");
        return NO;
    }
    
    //2.执行语句
    
    BOOL result = sqlite3_exec(_ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
    
    //3.关闭数据库
    sqlite3_close(_ppDb);
    
    return result;
    
}

+ (NSMutableArray <NSMutableDictionary *> *)querySql:(NSString *)sql uid:(NSString *)uid{
    
    //准备语句(预处理语句)
    if (! [self openDBWithUID:uid]) {
        NSLog(@"打开失败");
    }
    //1.创建准备语句
    //参数1: 一个已经打开的数据库
    //参数2: 需要的sql
    //参数3: 参数2取出多少字节的长度 -1 自动结算 \0
    //参数4: 准备语句 地址
    //参数5: 通过参数3 取出参数2的长度字节之后 剩下的字符串
    sqlite3_stmt *ppStmt = nil;
    if (sqlite3_prepare_v2(_ppDb, sql.UTF8String, -1, &ppStmt, nil) != SQLITE_OK) {
        NSLog(@"准备语句编译失败");
        return nil;
    }
    
    
    //2.绑定数据(省略)
    
    //3.执行
    //大数组
    NSMutableArray *rowDicArray = [NSMutableArray array];
    while (sqlite3_step(ppStmt) == SQLITE_ROW) {
        //一行记录 -->字典
        //解析一条记录(列,每一列的列名,每一列的值)
        
        //1.获取,列的个数
        int columnCount = sqlite3_column_count(ppStmt);
        
        NSMutableDictionary *rowDic = [NSMutableDictionary dictionary];
        // 2.遍历列(列名,值)
        for (int i = 0 ; i < columnCount; i ++) {
            //这一列的每一列
            //列名
            NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(ppStmt, i)];
            
            // 列的值
            // 不同的列, 如果类型不同, 我们需要使用不同的函数, 获取响应的值
            // 1. 获取这一列对应的类型
            int type = sqlite3_column_type(ppStmt, i);

            // 2. 根据不同的类型, 使用不同的函数,获取相应的值
            
            
            id value;
            
            switch (type) {
                case SQLITE_INTEGER:
                {
                    //NSLog(@"整形");
                    value = @(sqlite3_column_int(ppStmt, i));
                    break;
                }
                case SQLITE_FLOAT:
                {
                    //NSLog(@"浮点");
                    value = @(sqlite3_column_double(ppStmt, i));
                    break;
                }
                case SQLITE_BLOB:
                {
                    // NSLog(@"二进制");
                    value = CFBridgingRelease(sqlite3_column_blob(ppStmt, i));
                    break;
                }
                case SQLITE_NULL:
                {
                    //NSLog(@"空");
                    value = @"";
                    break;
                }
                case SQLITE3_TEXT:
                {
                    //NSLog(@"文本");
                    const char *valueC = (const char *)sqlite3_column_text(ppStmt, i);
                    value = [NSString stringWithUTF8String:valueC];
                    break;
                }
                    
                default:
                    break;
            }
        
            NSLog(@"%@---%@", columnName, value);
            
            [rowDic setValue:value forKey:columnName];
            
        }
        
    }
    
    //4.重置(省略)
    
    //5.释放资源
    sqlite3_finalize(ppStmt);
    [self closeDBWithUID:uid];
    
    return rowDicArray;
    
}

///打开数据库
+ (BOOL)openDBWithUID: (NSString *)uid {
    // 确定哪个数据库
    // cache
    NSString *dbPath;
    if (uid.length == 0) {
        dbPath = [kCachePath stringByAppendingPathComponent:@"Common.db"];
    }else {
        dbPath = [kCachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", uid]];
    }
    NSLog(@"数据库路径:%@",dbPath);
    // 1. 打开数据库(如果数据库不存在, 创建)
    if (sqlite3_open(dbPath.UTF8String, &_ppDb) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return NO;
    }
    return YES;
    
}

///关闭数据库
+ (void)closeDBWithUID: (NSString *)uid {

    sqlite3_close(_ppDb);
    
}


@end
