//
//  RealmDemoTests.m
//  RealmDemoTests
//
//  Created by Allison on 2017/8/20.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Realm/Realm.h>
#import "Stu.h"


@interface RealmDemoTests : XCTestCase

@end

@implementation RealmDemoTests


- (void)testSaveModel {
 
    Stu *stu = [[Stu alloc]initWithValue:@[@2,@"土豆"]];
    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    [realm addObject:stu];
//    [realm commitWriteTransaction];
    
    [realm transactionWithBlock:^{
        [realm addObject:stu];
        NSLog(@"num:%d name: %@",stu.num,stu.name);
    }];
    
//    [realm transactionWithBlock:^{
//        [Stu createInRealm:realm withValue:@{@"num":@3,@"name":@"哈哈"}];
//    }];
}

- (void)testDeleteModel {
    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//     Stu *stu = [[Stu alloc]initWithValue:@[@2,@"土豆"]];
//    //删除的模型,一定要求是被realm所管理的
//    [realm transactionWithBlock:^{
//        [realm deleteObject:stu];
//    }];

    //删除某一特定类型的所有模型
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *stuRes = [Stu allObjects];
    for (Stu *stu in stuRes) {
        [realm transactionWithBlock:^{
            [realm deleteObject:stu];
        }];
    }
    
    //场景 根据主键 删除一个模型
    //1.根据主键,查询到这个模型(这个模型,就是被realm数据库管理的模型)
    Stu *stuDel = [Stu objectInRealm:realm forPrimaryKey:@2];
    //2.删除该模型
    [realm transactionWithBlock:^{
        [realm deleteObject:stuDel];
    }];
    
}

- (void)testUpdate{
    
    //方法3:
    Stu *stu = [[Stu alloc]initWithValue:@[@2,@"土豆"]];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:stu];
        NSLog(@"num:%d name: %@",stu.num,stu.name);
//        [Stu createOrUpdateInRealm:realm withValue:@{@"num":@3,@"name":@"哈哈"}];
    }];
    
    //方法2:
//    Stu *stu = [[Stu alloc]initWithValue:@[@2,@"土豆"]];
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    //这个模型stu已经被realm管理,而且已经和磁盘上的对象进行了地址映射
//    [realm transactionWithBlock:^{
//        [realm addObject:stu];
//        NSLog(@"num:%d name: %@",stu.num,stu.name);
//
//    }];
//    //这里面修改的模型,一定是被realm所管理的模型
//    [realm transactionWithBlock:^{
//        stu.name = @"拉阿拉";
//        NSLog(@"num:%d name: %@",stu.num,stu.name);
//
//    }];

    
    //方法1:
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    RLMResults *results = [Stu objectsWhere:@"name = '拉阿拉'"];
//    Stu *stu =  results.firstObject;
//    
//    [realm transactionWithBlock:^{
//        stu.name = @"xxxxxxx拉阿拉xxxxxxxx";
//        NSLog(@"num:%d name: %@",stu.num,stu.name);
//
//    }];

}

@end
