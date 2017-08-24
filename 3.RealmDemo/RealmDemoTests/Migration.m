//
//  Migration.m
//  RealmDemo
//
//  Created by Allison on 2017/8/23.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Realm/Realm.h>
#import "Stu.h"

@interface Migration : XCTestCase

@end

@implementation Migration


-(void)setUp{
    [super setUp];
    //1.获取默认配置
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    //2.叠加版本号(要比上一次的版本号高) 0
    int newVersion = 7;
    config.schemaVersion = newVersion;
    
    //3.具体怎样迁移
    [config setMigrationBlock:^(RLMMigration *migration, uint64_t oldSchemaVersion){
        if (oldSchemaVersion < newVersion) {
            NSLog(@"需要做迁移操作");
            
            //执行更名动作
            [migration renamePropertyForClass:@"Stu" oldName:@"fullName" newName:@"fullName2"];
            
            
//            [migration enumerateObjects:@"Stu" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
//                newObject[@"fullName"] = [NSString stringWithFormat:@"%@%@",newObject[@"preName"],newObject[@"lastName"]];
//            }];
        }
    }];
    
    //4.让配置生效
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    //5.如果需要立即生效
    [RLMRealm defaultRealm];
    
    
}

- (void)testExample {
    RLMRealm *realm = [RLMRealm defaultRealm];
    Stu *stu = [[Stu alloc]init];
    stu.name = @"Allison";
    stu.preName = @"XXXXX";
    stu.lastName = @"wangjiaojiao";
    stu.fullName2 = @"哈哈哈哈";
    [realm transactionWithBlock:^{
        [realm addObject:stu];
        NSLog(@" ------- name: %@,preName:%@,lastName:%@,fullName:%@",stu.name,stu.preName,stu.lastName,stu.fullName2);
    }];
}



@end
