//
//  YTableTool.h
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

///这个类是动态更新表--数据迁移类
//注意:动态更新表的前提是表需要更新
//判断是否更新表的条件:
//1.根据模型,可以拿到有效的成员变量的名称
//2.从老表格中获取字段的名称和类型 
#import <Foundation/Foundation.h>

@interface YTableTool : NSObject

/** 获取表格里面所有的字段 */
+ (NSArray *)getTableAllColumnNames: (Class )cls uid: (NSString *)uid;


@end
