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


@end
