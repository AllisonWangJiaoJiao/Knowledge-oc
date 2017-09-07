//
//  YSqliteModelTool.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "YSqliteModelTool.h"
#import "YModelTool.h"
#import "YModel.h"
#import "YSqliteTool.h"

@implementation YSqliteModelTool

//动态创建表
+ (BOOL)createTable:(Class)cls uid:(NSString *)uid{
    
    //1.创建表格的sql拼接起来执行
    
    //1.1获取表的名称
    NSString *tableName = [YModelTool getTableNameWithModelClass:cls];
    
    if (! [cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作你这个模型, 必须要通过 - (NSString *)primaryKey; 方法, 来提供一个主键");
        return NO;
    }
   
    // 获取主键
    NSString *primaryKey = [cls primaryKey];
    //1.2获取一个模型里面的所有字段以及类型
    NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@,PRIMARY KEY(%@))",tableName, [YModelTool columnNameAndTypesStr:cls],primaryKey];
    
    //2.执行
    return [YSqliteTool dealSql:createTableSql withUid:uid];
}



@end
