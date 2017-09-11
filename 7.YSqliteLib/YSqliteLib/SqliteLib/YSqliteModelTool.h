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

@interface YSqliteModelTool : NSObject

/**
  判断表格是否需要更新数据
 */
+ (BOOL)isTableRequiredUpdate:(Class)cls uid: (NSString *)uid;

///动态创建表
+ (BOOL)createTable:(Class)cls uid:(NSString *)uid;
///更新表
+ (BOOL)updateTable: (Class)cls uid: (NSString *)uid;


@end
