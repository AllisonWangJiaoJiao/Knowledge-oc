//
//  YModel.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "YModel.h"

@implementation YModel

+(NSString*)primaryKey{
    
    return @"stuNum";
}
//+ (NSArray *)ignoreIvarNames{
//    return @[@"score2",@"score3"];
//}

+ (NSDictionary *)newNameToOldNameDic{
    return @{@"age":@"age2"};
}

@end
