//
//  YSqliteModelTool.h
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

///这个类专门操作数据模型的类,面向模型的类
//关于这个工具类的封装 实现的方法有两种
//1.基于配置
//2.runtime动态获取

#import <Foundation/Foundation.h>
#import "YModelProtocol.h"

typedef NS_ENUM(NSUInteger, ColumnNameToValueRelationType) {
    ColumnNameToValueRelationTypeMore,
    ColumnNameToValueRelationTypeLess,
    ColumnNameToValueRelationTypeEqual,
    ColumnNameToValueRelationTypeMoreEqual,
    ColumnNameToValueRelationTypeLessEqual,
};

typedef NS_ENUM(NSUInteger, YSqlieModelToolNAO) {
    YSqliteModelToolNAONot,
    YSqliteModelToolNAOAnd,
    YSqliteModelToolNAOOr,
};


@interface YSqliteModelTool : NSObject

/**
 判断表格是否需要更新数据

 @param cls cls
 @param uid uid
 @return 是否动态更新数据成功
 */
+ (BOOL)isTableRequiredUpdate:(Class)cls uid: (NSString *)uid;


/**
 动态创建表

 @param cls cls
 @param uid uid
 @return 是否动态创建表成功
 */
+ (BOOL)createTable:(Class)cls uid:(NSString *)uid;

/**
 更新表格

 @param cls 类名
 @param uid 用户唯一标示
 @return 是否更新成功
 */
+ (BOOL)updateTable: (Class)cls uid: (NSString *)uid;


/**
 根据model去删除

 @param model model
 @param uid uid
 @return 是否删除成功
 */
+ (BOOL)deleteModel:(id)model uid:(NSString *)uid;


/**
 根据条件来删除 --where score <= 4

 @param cls cls
 @param whereStr 条件
 @return 是否删除成功
 */
+ (BOOL)deleteModel:(Class)cls whereStr:(NSString *)whereStr uid:(NSString *)uid;


/**
 根据条件来删除 -- 列名

 @param cls 类
 @param name 列名
 @param relation 关系 > < =
 @param value 值
 @param uid uid
 @return 是否删除成功
 */
+ (BOOL)deleteModel:(Class)cls cloumnName:(NSString *)name relation:(ColumnNameToValueRelationType)relation value:(id)value uid :(NSString *)uid;

/**
 根据条件来删除 -- @[@"name",@"age"]  @[@">",@"="] @[@"10",@"xx"]

 @param cls 类
 @param keys 列名
 @param relations 关系 > < =
 @param values 值
 @param naos not and or
 @param uid uid
 @return 是否删除成功
 */
+ (BOOL)deleteModel:(Class)cls keys: (NSArray *)keys relations: (NSArray *)relations values: (NSArray *)values nao: (NSArray *)naos uid: (NSString *)uid;

/**
 根据条件来删除 -- sql语句

 @param sql sql语句
 @param uid uid
 @return 是否删除成功
 */
+ (BOOL)deleteWithSql:(NSString *)sql uid:(NSString *)uid;

@end
