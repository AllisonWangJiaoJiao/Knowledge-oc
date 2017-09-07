//
//  YModelTool.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "YModelTool.h"
#import <objc/runtime.h>

@implementation YModelTool

/**
 获取表格名称
 */
+ (NSString *)getTableNameWithModelClass: (Class)cls{
      return [NSStringFromClass(cls) lowercaseString];
}

/**
 所有成员变量,以及成员变量对应的类型
 */
+ (NSDictionary *)getModelIvarNameIvarTypeDic: (Class)cls{
    unsigned int outCount = 0 ;
   //取出所有成员变量列表
   Ivar *varList =  class_copyIvarList(cls,&outCount);
    NSMutableDictionary *nameTypeDic = [NSMutableDictionary dictionary];
    //遍历成员变量列表
    for (int i = 0; i < outCount; i++) {
        //取出成员变量
        Ivar ivar = varList[i];
        //1.获取成员变量名称
        NSString *ivarName =  [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([ivarName hasPrefix:@"_"]) {
            ivarName = [ivarName substringFromIndex:1];
        }
        //2.获取成员变量类型
        NSString *ivarType = [[NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        
        [nameTypeDic setValue:ivarType forKey:ivarName];
    }
    return nameTypeDic;
}

/**
 所有成员变量,以及成员变量映射到数据库里面对应的类型
 */
+ (NSDictionary *)getModelIvarNameSqliteTypeDic: (Class)cls{
    
       NSMutableDictionary *ivarNameIvarTypeDic = [[self getModelIvarNameIvarTypeDic:cls] mutableCopy];
    NSDictionary *rTTSt = [self runtimeTypeToSqlTypeDic];
    [ivarNameIvarTypeDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
       [ivarNameIvarTypeDic setValue:rTTSt[obj] forKey:key];
    }];
     return ivarNameIvarTypeDic;
}
/**
 创建表格的sql字段和类型的语句拼接
 */
+ (NSString *)columnNameAndTypesStr:(Class)cls{

    NSMutableArray *result = [NSMutableArray array];
    NSDictionary *nameTypeDic = [self getModelIvarNameSqliteTypeDic:cls];
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        [result addObject:[NSString stringWithFormat:@"%@ %@",key,obj]];
    }];
    
   return [result componentsJoinedByString:@","];
    
}


#pragma mark --私有的方法
/**
 runtime的字段类型到sql字段类型的映射表
 */
+ (NSDictionary *)runtimeTypeToSqlTypeDic {
    
    return @{
             @"d": @"real", // double
             @"f": @"real", // float
             
             @"i": @"integer",  // int
             @"q": @"integer", // long
             @"Q": @"integer", // long long
             @"B": @"integer", // bool
             
             @"NSData": @"blob",
             @"NSDictionary": @"text",
             @"NSMutableDictionary": @"text",
             @"NSArray": @"text",
             @"NSMutableArray": @"text",
             
             @"NSString": @"text",
             @"NSMutableString": @"text"
             };
}



@end
