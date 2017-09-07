//
//  YSqliteTool.h
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSqliteTool : NSObject

+ (BOOL)dealSql: (NSString *)sql withUid: (NSString *)uid;

///返回值:字典(一行记录)组成的数组
+ (NSMutableArray <NSMutableDictionary *> *)querySql:(NSString *)sql uid:(NSString *)uid;

@end
