//
//  YModelToolsTest.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YModelTool.h"
#import "YModel.h"
#import "YSqliteModelTool.h"
#import "YSqliteTool.h"
#import "YTableTool.h"

@interface YModelToolsTest : XCTestCase

@end

@implementation YModelToolsTest

- (void)testTvarNameType {
    
//   NSDictionary *dic =  [YModelTool getModelIvarNameIvarTypeDic:[YModel class]];
//    NSDictionary *dic = [YModelTool getModelIvarNameSqliteTypeDic:[YModel class]];
//    NSLog(@"%@",dic);
    
//    NSString *sql = [YModelTool columnNameAndTypesStr:[YModel class]];
//    NSLog(@"---- %@",sql);
//    [YTableTool getTableAllColumnNames:[YModel class] uid:nil];
    

    
    BOOL result = [YSqliteModelTool updateTable:[YModel class] uid:nil];
     NSLog(@"---- %d",result);
}
/**
 输出数据库路径
 */
- (void)testDBPath{
    
    [YSqliteTool openDBWithUID:nil];
}
/**
 测试创建表格
 */
- (void)testCreateTable{
    
    BOOL result = [YSqliteModelTool createTable:[YModel class] uid:nil];
    NSLog(@"---- %d",result);
}

/**
 测试是否需要更新
 */
- (void)testEequiredUpdate {
    BOOL result =  [YSqliteModelTool isTableRequiredUpdate:[YModel class] uid:nil];
    NSLog(@"---- %d",result);
}

/**
 字段改名
 */
- (void)testUpdateTable{
   BOOL update =  [YSqliteModelTool updateTable:[YModel class] uid:nil];
    NSLog(@"%d",update);
}


/**
 数据删除
 */
- (void)testDeleteModel{
    YModel *model = [[YModel alloc]init];
    model.stuNum = 11;

    BOOL delete = [YSqliteModelTool deleteModel:model uid:nil ];
    NSLog(@"%d",delete);

}

- (void)testDeleteModelWhere{
    YModel *model = [[YModel alloc]init];
    model.stuNum = 11;
    
    BOOL delete = [YSqliteModelTool deleteModel:[YModel class] whereStr:@"score <= 4" uid:nil ];
    NSLog(@"%d",delete);
    
}

- (void)testDeleteModelRelationType{
    YModel *model = [[YModel alloc]init];
    model.stuNum = 11;
    
    BOOL delete = [YSqliteModelTool deleteModel:[YModel class] cloumnName:@"name" relation:ColumnNameToValueRelationTypeEqual value:@44 uid:nil];
    NSLog(@"%d",delete);
    
}

- (void)testDeleteModelRelationType2{
    
    BOOL delete = [YSqliteModelTool deleteModel:[YModel class] keys:@[@"age",@"name",@"stuNum"] relations:@[@(ColumnNameToValueRelationTypeMore),@(ColumnNameToValueRelationTypeEqual),@(ColumnNameToValueRelationTypeEqual)] values:@[@"1",@"44",@"22"] nao:@[@(YSqliteModelToolNAOAnd),@(YSqliteModelToolNAOAnd)] uid:nil];
    NSLog(@"%d",delete);
    
}

- (void)testDeleteWithSql{
    
    NSString *sql = @"delete from ymodel where age > '100' and name = '444'";
    BOOL delete = [YSqliteModelTool deleteWithSql:sql uid:nil];
    NSLog(@"%d",delete);

}


@end
