//
//  UserDBManager.m
//  FMDB_Demo
//
//  Created by WanWan. on 2017/7/10.
//  Copyright © 2017年 iamwanwan. All rights reserved.
//

#import "UserDBManager.h"
#import "FMDB.h"
#import "User.h"

@interface UserDBManager ();
@property (nonatomic, copy) NSString *dbPath;//数据库路径
@property (nonatomic, strong) FMDatabaseQueue *queue;//sql执行队列
@end

@implementation UserDBManager
-(instancetype)init {
    self = [super init];
    if (self) {
        [self createTableIfNeed];
    }
    return self;
}

#pragma mark - get set
-(NSString *)dbPath {
    if (!_dbPath) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        _dbPath = [doc stringByAppendingPathComponent:@"user.sqlite"];
    }
    return _dbPath;
}
-(FMDatabaseQueue *)queue {
    if (!_queue) {
        _queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _queue;
}

#pragma mark - t_user sql 表结构处理
-(void)createTableIfNeed {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase*db) {
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT, uId text NOT NULL, name text NOT NULL, age integer NOT NULL, money double NOT NULL DEFAULT 0 );"];
        NSAssert(result, @"t_user 创建失败");
    }];
}


-(void)addColumnWithNameSql:(NSString*)nameSql result:(void(^)(BOOL success))res  {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString* sql = [NSString stringWithFormat:@"ALTER TABLE t_user add %@;", nameSql];
        BOOL result = [db executeUpdate:sql];
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}

-(void)deleteColumn:(NSString *)columnName result:(void(^)(BOOL success))res {
    [self deleteColumnWithNames:@[columnName] table:@"t_user" result:res];
}
#pragma mark - t_user sql 增删改查

-(void)allDataWithCallBack:(void(^)(NSArray<User*> *array))callBack {
    if (callBack) {
        FMDatabaseQueue *queue = self.queue;
        [queue inDatabase:^(FMDatabase*db) {
//            FMResultSet *set= [db executeQuery:@"select id, uId, name, age, money from t_user"];
            FMResultSet *set= [db executeQuery:@"SELECT * FROM t_user"];//带条件查询此处增加 where 条件即可

            NSMutableArray *arr = [NSMutableArray array];
            while([set next]) {
//                int ID = [set intForColumn:@"id"];
                NSString *uId = [set stringForColumn:@"uId"];
                NSString *name = [set stringForColumn:@"name"];
                int age = [set intForColumn:@"age"];
                int sex = 0;
                NSString *str = [[set columnNameToIndexMap] objectForKey:@"sex"];
                if (str != nil) {
                    sex = [set intForColumn:@"sex"];
                }
                double money = [set doubleForColumn:@"money"];
                User *user = [[User alloc] init];
                user.uId = uId;
                user.name = name;
                user.age = age;
                user.money = money;
                user.sex = sex;
                [arr addObject:user];
            }
            [set close];
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(arr);
            });
        }];
    }
}

-(void)insertUser:(User*)user result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {//注意属性值是否为空与标字段是否可空
       BOOL result = [db executeUpdate:@"INSERT INTO t_user(name, age, money) VALUES (?,?,?,?);", user.uId, user.name, @(user.age), @(user.money)];
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}

-(void)updateUser:(User*)user result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {//注意属性值是否为空与标字段是否可空
        FMResultSet *set = [db executeQuery:@"SELECT count(*) AS count FROM t_user WHERE uId = ?;", user.uId];
        NSInteger rowCount = 0;
        BOOL result = NO;
        if ([set next]) {
            rowCount = [set intForColumn:@"count"];
        }
        [set close];
        if (rowCount >0 ) {
            result = [db executeUpdate:@"UPDATE t_user SET name = ?, age = ?, money = ? WHERE uId = ?;", user.name, @(user.age), @(user.money), user.uId];
        }else{
            result = [db executeUpdate:@"INSERT INTO t_user(uId, name, age, money) VALUES (?,?,?,?);", user.uId, user.name, @(user.age), @(user.money)];
        }
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}


-(void)updateUsers:(NSArray<User*> *)users result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {//注意属性值是否为空与标字段是否可空
        BOOL result = YES;
        for (User *user in users) {
            FMResultSet *set = [db executeQuery:@"SELECT count(*) AS count FROM t_user WHERE uId = ?;", user.uId];
            NSInteger rowCount = 0;
            if ([set next]) {
                rowCount = [set intForColumn:@"count"];
            }
            [set close];
            if (rowCount > 0 ) {
                result = [db executeUpdate:@"UPDATE t_user SET name = ?, age = ?, money = ? WHERE uId = ?;", user.name, @(user.age), @(user.money), user.uId];
            }else{
                result = [db executeUpdate:@"INSERT INTO t_user(uId, name, age, money) VALUES (?,?,?,?);", user.uId, user.name, @(user.age), @(user.money)];
            }
        }
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
        
    }];
}

-(void)resetAll:(NSArray<User*> *)users result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {//注意属性值是否为空与标字段是否可空
        BOOL result = [db executeUpdate:@"DELETE FROM t_user;"];
        if (result) {
            for (User *user in users) {
                result = [db executeUpdate:@"INSERT INTO t_user(name, age, money) VALUES (?,?,?);", user.name, @(user.age), @(user.money)];
                if (!result) {
                    //...插入失败
                }
            }
        }
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}


-(void)deleteUserWithUId:(NSString*)uId result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result;
        if (uId) {
            result = [db executeUpdate:@"DELETE FROM t_user;"];
        }else{
            result = [db executeUpdate:@"DELETE FROM t_user WHERE uId = ?;", uId];
        }
        
//        NSArray *uIds;
//        if (uIds.count>0) {
//            NSString *delString = [NSString stringWithFormat:@"DELETE FROM t_user WHERE uId in ('%@')", [uIds componentsJoinedByString:@"','"]];//批量删除
//        }
        
        result = [db executeUpdate:@"DELETE FROM t_user WHERE uId = ?;", uId];

        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}

-(void)deleteUserWithUIdArray:(NSArray<NSString*>*)uIds result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result;
        if (uIds.count == 0) {
            result = [db executeUpdate:@"DELETE FROM t_user;"];
//        }else
//        if (uIds.count == 1) {//可省略
//            result = [db executeUpdate:@"DELETE FROM t_user WHERE uId = ?;", uIds[0]];
        }else {
             NSString *delString = [NSString stringWithFormat:@"DELETE FROM t_user WHERE uId in ('%@');", [uIds componentsJoinedByString:@"','"]];
            result = [db executeUpdate:delString];
        }
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}

#pragma mark - 表字段操作__新增（通用方法）
-(void)addColumnWithNameSql:(NSString*)nameSql table:(NSString*)tableName result:(void(^)(BOOL success))res  {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString* sql = [NSString stringWithFormat:@"ALTER TABLE %@ add %@;", tableName, nameSql];
        BOOL result = [db executeUpdate:sql];
        if (res) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}

#pragma mark - 表字段操作__删除（通用方法）
-(void)deleteColumnWithNames:(NSArray <NSString *>*)delNames table:(NSString*)tableName result:(void(^)(BOOL success))res {
    FMDatabaseQueue *queue = self.queue;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = YES, isDelete = NO;;
        //获取table的 CREATE 语句
        FMResultSet *set = [db executeQuery:@"SELECT sql FROM sqlite_master WHERE tbl_name = ? AND type='table'", tableName];
        if ([set next]) {
            NSString *sql = [set stringForColumn:@"sql"];
            NSString *columnStr = [[sql componentsSeparatedByString:@"("][1] stringByReplacingOccurrencesOfString:@")" withString:@""];//获取CREATE语句内表字段部分
            NSMutableArray *columnArray = [[columnStr componentsSeparatedByString:@","]mutableCopy];//字段名和类型等其它字段属性
            NSInteger count = columnArray.count;
            NSMutableArray *columnNameArray = [NSMutableArray array];//仅字段名
            for (NSString*column in columnArray) {
                NSString *tmp = [column stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去首位空格
                NSString* cName = [tmp componentsSeparatedByString:@" "].firstObject;//获取字段名（字段名 字段属性）
                if ([delNames containsObject:cName]) {
                    [columnArray removeObject:column];//删除字段
                }else {
                    [columnNameArray addObject:cName];
                }
            }
            if (columnArray.count != count) {
                isDelete = YES;
                NSString *columnNames = [columnNameArray componentsJoinedByString:@", "];
                NSString *tableName_tmp = [tableName stringByAppendingString:@"_tmp"];//名称可改用随机字符串，注意临时表名是否存在
                NSString *renameTableSql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@;\n",tableName,tableName_tmp];
                NSString *newTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@);\n", tableName, [columnArray componentsJoinedByString:@", "]];
                NSString *resetTableSql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) SELECT %@ FROM %@;\n", tableName, columnNames, columnNames, tableName_tmp];
                NSString *dropTmpTableSql = [NSString stringWithFormat:@"DROP TABLE %@;\n",tableName_tmp];
                NSMutableString *allSql = [NSMutableString string];
                [allSql appendString:renameTableSql];
                [allSql appendString:newTableSql];
                [allSql appendString:resetTableSql];
                [allSql appendString:dropTmpTableSql];
                dispatch_async(dispatch_get_main_queue(), ^{//queue直接嵌套调用导致gcd死锁
                    [queue inDatabase:^(FMDatabase * _Nonnull db) {//同一个queue内执行出现数据库锁（database table is locked）
                        BOOL result = [db executeStatements:allSql];
                        if (res) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                res(result);
                            });
                        }
                    }];
                });
            }
            [set close];//避免 Warning: there is at least one open result set around after performing
        }
        if (res && !isDelete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                res(result);
            });
        }
    }];
}


@end
