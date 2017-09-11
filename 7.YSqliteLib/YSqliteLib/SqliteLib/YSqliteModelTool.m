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
#import "YTableTool.h"

@implementation YSqliteModelTool


/**
 判断表格是否需要更新数据
 */
+ (BOOL)isTableRequiredUpdate:(Class)cls uid: (NSString *)uid{
    
    //1. 获取模型里面所有的字段
    NSArray *modelNames = [YModelTool getAllTableSortedModelIvarNames:cls];
    //2.获取老表中的字段的名称
    NSArray *tableNames = [YTableTool getTableAllColumnNames:cls uid:uid];
    //3.直接对比数组
    return ![modelNames isEqualToArray:tableNames];
}


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
///更新表
+ (BOOL)updateTable: (Class)cls uid: (NSString *)uid{
    //1.创建一个拥有正确结构的临时表
    //1.1获取表的名称
    NSString *tmpTableName = [YModelTool getTempTableNameWithModelClass:cls];
    NSString *tableName = [YModelTool getTableNameWithModelClass:cls];
    
    if (! [cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作你这个模型, 必须要通过 - (NSString *)primaryKey; 方法, 来提供一个主键");
        return NO;
    }
    NSMutableArray *execSqlsArr = [NSMutableArray array];
    // 获取主键
    NSString *primaryKey = [cls primaryKey];
    NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@,PRIMARY KEY(%@))",tmpTableName, [YModelTool columnNameAndTypesStr:cls],primaryKey];
    [execSqlsArr addObject:createTableSql];
    
    //2.根据主键插入数据
    //INSERT INTO tem_ymodel(age )SELECT age FROM ymodel
    NSString *insertPrimaryKeySql = [NSString stringWithFormat:@"INSERT INTO %@(%@ )SELECT %@ FROM %@ ",tmpTableName,primaryKey,primaryKey,tableName];
    [execSqlsArr addObject:insertPrimaryKeySql];
    
    //3.根据主键,把所有的数据更新到新表
    NSArray *oldNammesArr = [YTableTool getTableAllColumnNames:cls uid:uid];
    NSArray *newsNamesArr = [YModelTool getAllTableSortedModelIvarNames:cls];
    
    //4.获取更名字典
    NSDictionary *newNameToOldNameDic = @{};
    //@{@"age":@"age2"}
    if ([cls respondsToSelector:@selector(newNameToOldNameDic)]) {
        newNameToOldNameDic = [cls newNameToOldNameDic];
    }
    for (NSString *columnName in newsNamesArr) {
        NSString *oldName = columnName;
        //找映射的旧的字段名称
        if ([newNameToOldNameDic[columnName] length] != 0) {
            oldName = newNameToOldNameDic[columnName];
        }
        //如果老表里面包含了新的列名 应该从老表更新到临时表格里面
        if ((![oldNammesArr containsObject:columnName] && [oldNammesArr containsObject:oldName]) || [oldName isEqualToString:primaryKey]) {
            continue;
        }
        //update 临时表 set 新字段名称 = (select 旧的字段名 from 旧表 where 临时表.主键 - 旧表.主键)
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = (SELECT %@ FROM %@ WHERE %@.%@ = %@.%@)",tmpTableName,columnName,oldName,tableName,tmpTableName,primaryKey,tableName,primaryKey];
        [execSqlsArr addObject:updateSql];

    }
    //4.删除表
    NSString *deleteOldTableSql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",tableName];
    [execSqlsArr addObject:deleteOldTableSql];
    //5.更新表名
    NSString *renameTableNameSql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@",tmpTableName,tableName];
    [execSqlsArr addObject:renameTableNameSql];
    
    return [YSqliteTool dealSqls:execSqlsArr uid:uid];
}




@end
