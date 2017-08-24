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
    
    
    [self setDefaultRealmForUser:@"Allison"];
 
    RLMRealm *realm = [RLMRealm defaultRealm];
    Stu *stu = [[Stu alloc]initWithValue:@[@3,@"土豆"]];
    [realm transactionWithBlock:^{
        [realm addObject:stu];
//        NSLog(@"num:%d name: %@",stu.num,stu.name);
    }];
    
//    [realm transactionWithBlock:^{
//        [Stu createInRealm:realm withValue:@{@"num":@3,@"name":@"哈哈"}];
//    }];
}
- (void)setDefaultRealmForUser:(NSString *)username{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    //使用默认的目录,使用用户名来替换默认的文件名
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]URLByAppendingPathComponent:username]URLByAppendingPathExtension:@"realm"];
    //将这个配置应用到默认的realm数据库中
    [RLMRealmConfiguration setDefaultConfiguration:config];
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

- (void)testQuryModel {
    
    //所有的查询(包括查询和属性访问)在realm中都是延迟加载的,终于当属性被访问时,才能够读取相应的数据
    RLMResults *result = [Stu allObjects];
    NSLog(@"%@",result);
    
    ///方法2
    RLMResults <Stu *> *stus = [Stu objectsWhere:@"name = '土豆'"];
//    NSLog(@"%@",stus);
    
    ///方法3
    RLMResults *sorRes =  [result sortedResultsUsingKeyPath:@"name" ascending:YES];
    NSLog(@"%@",sorRes);
    
    //方法4
    ///链式查询
    RLMResults *subRes = [sorRes objectsWhere:@"name = '哈哈'"];
    NSLog(@"%@",subRes);
    
}


- (void)testUpdate{
    
    //方法3:
    Stu *stu = [[Stu alloc]initWithValue:@[@2,@"土豆"]];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:stu];
//        NSLog(@"num:%d name: %@",stu.num,stu.name);
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
