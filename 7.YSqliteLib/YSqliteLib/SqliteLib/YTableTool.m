//
//  YTableTool.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "YTableTool.h"
#import "YModelTool.h"
#import "YSqliteTool.h"


@implementation YTableTool

/** 获取表格里面所有的字段 */
+ (NSArray *)getTableAllColumnNames: (Class )cls uid: (NSString *)uid{
    
    NSString *tableName = [YModelTool getTableNameWithModelClass:cls];
    // 1.获取老表中的字段的名称
    NSString *queryCreateSqlStr = [NSString stringWithFormat:@"SELECT sql FROM sqlite_master WHERE type='table' AND name ='%@'",tableName];
   NSMutableDictionary *dic = [YSqliteTool querySql:queryCreateSqlStr uid:uid].firstObject;
    NSString *createTableSql = [dic[@"sql"] lowercaseString];
    if (createTableSql.length == 0) {
        return nil;
    }

    //CREATE TABLE ymodel(age integer,stuNum integer,score real,name text,PRIMARY KEY(stuNum))
    //2.对sql进行分割
    //age integer,stuNum integer,score real,name text,PRIMARY KEY
    NSString *nameTypeStr = [createTableSql componentsSeparatedByString:@"("][1];

    //age integer
    //stuNum integer
    //score real
    //name text
    //PRIMARY KEY
    NSArray *nameTypeArray = [nameTypeStr componentsSeparatedByString:@","];
    NSMutableArray *namesArr = [NSMutableArray array];
    for (NSString *nameType in nameTypeArray) {
        if ([nameType containsString:@"primary"]) {
            continue;
        }
        //age integer
      NSString *name = [nameType componentsSeparatedByString:@" "].firstObject;
      [namesArr addObject:name];
    }
    
    [namesArr sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
 
    return namesArr;
}

@end
