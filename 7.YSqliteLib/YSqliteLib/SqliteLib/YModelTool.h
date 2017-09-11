//
//  YModelTool.h
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

///这个类主要用来操作model

#import <Foundation/Foundation.h>

@interface YModelTool : NSObject

/**
 获取表格名称
 */
+ (NSString *)getTableNameWithModelClass: (Class)cls;
/**
 获取临时表格名称
 */
+ (NSString *)getTempTableNameWithModelClass: (Class)cls;

/**
 所有成员变量,以及成员变量对应的类型
 */
+ (NSDictionary *)getModelIvarNameIvarTypeDic: (Class)cls;

/**
 所有成员变量,以及成员变量映射到数据库里面对应的类型
 */
+ (NSDictionary *)getModelIvarNameSqliteTypeDic: (Class)cls;

/**
 创建表格的sql字段和类型的语句拼接
 */
+ (NSString *)columnNameAndTypesStr:(Class)cls;

/**
 获取模型里面所有的字段
 */
+ (NSArray <NSString *> *)getAllTableSortedModelIvarNames: (Class)cls;


@end
