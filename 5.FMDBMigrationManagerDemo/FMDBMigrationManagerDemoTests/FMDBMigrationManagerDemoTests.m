//
//  FMDBMigrationManagerDemoTests.m
//  FMDBMigrationManagerDemoTests
//
//  Created by Allison on 2017/8/24.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMDatabase.h"
#import "FMDBMigrationManager.h"
#import "Migration.h"

@interface FMDBMigrationManagerDemoTests : XCTestCase
@property(nonatomic,strong)FMDatabase *db;

@end

@implementation FMDBMigrationManagerDemoTests

- (void)testExample {
    
    //生成数据库
    //    [self creatSqlite];
    //检查并升级数据库
    //    [self updatePrivateMsg];
}


- (void)testcreatSqlite{
    
    NSString *filePath = [self getPath];
    NSLog(@"-----filePath:%@",filePath);
    FMDatabase * db=[FMDatabase databaseWithPath:filePath];
    _db=db;
    
    if ([_db open]) {
        //创建一个名为Student的表 包含一个字段name
        
        BOOL result = [_db executeUpdate:@"CREATE TABLE  if not exists Book (id integer primary key autoincrement, bookNumber integer, bookName text, authorID integer, pressName text);"];
        
        if (result) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
        
        //存入十个水浒传
        for (int i=0; i<10; i++) {
            NSString *bookName = [NSString stringWithFormat:@"水浒传%d",i+1];
            NSString *bookNumber = [NSString stringWithFormat:@"数量%d",i+1];
            [_db executeUpdate:@"INSERT INTO book (bookName,bookNumber) VALUES (?,?)",bookName,bookNumber];
        }
    }
    
    
    [_db close];
}

- (void)testupdatePrivateMsg{
    
    NSString *filePath = [self getPath];
    NSLog(@"-----filePath:%@",filePath);
    FMDBMigrationManager * manager=[FMDBMigrationManager managerWithDatabaseAtPath:filePath migrationsBundle:[NSBundle mainBundle]];
    
    Migration * migration_1=[[Migration alloc]initWithName:@"Student" andVersion:1 andExecuteUpdateArray:@[@"create table Student(id integer PRIMARY KEY AUTOINCREMENT,number text,name text,authorid text,prename text)"]];//从版本生升级到版本1创建一个Student表 带有 name,age 字段
    
    Migration * migration_2=[[Migration alloc]initWithName:@"Book" andVersion:2 andExecuteUpdateArray:@[@"alter table Book add book_email text"]];//给User表添加email字段
    
    Migration * migration_3=[[Migration alloc]initWithName:@"Book" andVersion:3 andExecuteUpdateArray:@[@"alter table Book add book_address text"]];
    //
    [manager addMigration:migration_1];
    [manager addMigration:migration_2];
    [manager addMigration:migration_3];
    
    BOOL resultState=NO;
    NSError * error=nil;
    if (!manager.hasMigrationsTable) {
        resultState=[manager createMigrationsTable:&error];
    }
    resultState=[manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
    //    NSLog(@"------- Origin Version: %llu", manager.originVersion);
    //    NSLog(@"------- Current version: %llu", manager.currentVersion);
    //    NSLog(@"------- All migrations: %@", manager.migrations);
    //    NSLog(@"------- Applied versions: %@", manager.appliedVersions);
    //    NSLog(@"------- Pending versions: %@", manager.pendingVersions);
    
    
    //    FMDatabase * db=[FMDatabase databaseWithPath:filePath];
    //    _db=db;
    //    if ([_db open]) {
    //        for (int i=0; i<10; i++) {
    //            NSString *email = [NSString stringWithFormat:@"'%@'",@"wangjiaojiao@qq.com"];
    //            NSString *sql = [NSString stringWithFormat:@"UPDATE Book SET book_email = %@ WHERE id = %d;",email,i];
    //            BOOL res2 = [_db executeUpdate:sql];
    //            if (res2) {
    //                NSLog(@"成功");
    //            }
    //        }
    //    }
    
}

- (NSString *)getPath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"BOOK.sqlite"];
}



@end
