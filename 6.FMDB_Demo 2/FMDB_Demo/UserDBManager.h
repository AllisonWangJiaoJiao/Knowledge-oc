//
//  UserDBManager.h
//  FMDB_Demo
//
//  Created by WanWan. on 2017/7/10.
//  Copyright © 2017年 iamwanwan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface UserDBManager : NSObject

/**
 获取所有user数据

 @param callBack UserArray
 */
-(void)allDataWithCallBack:(void(^)(NSArray<User*> *array))callBack;

/**
 插入user

 @param user user
 @param res <#res description#>
 */
-(void)insertUser:(User*)user result:(void(^)(BOOL success))res;

/**
 更新user，user不存在时候为插入操作

 @param user user
 @param res <#res description#>
 */
-(void)updateUser:(User*)user result:(void(^)(BOOL success))res;

/**
 批量更新user，user不存在时候为插入操作

 @param users user数组
 @param res <#res description#>
 */
-(void)updateUsers:(NSArray<User*> *)users result:(void(^)(BOOL success))res;

/**
 重制数据，清空表后插入users

 @param users user数组
 @param res <#res description#>
 */
-(void)resetAll:(NSArray<User*> *)users result:(void(^)(BOOL success))res;

/**
 根据多个uId删除数据

 @param uIds 用户id数组
 @param res <#res description#>
 */
-(void)deleteUserWithUIdArray:(NSArray<NSString*>*)uIds result:(void(^)(BOOL success))res;

/**
 根据uid删除数据，id == nil 时候删除全部数据

 @param uId 用户id，id == nil 时候删除全部数据
 @param res <#res description#>
 */
-(void)deleteUserWithUId:(NSString*)uId result:(void(^)(BOOL success))res;

/**
 增加字段

 @param nameSql 字段名 类型 是否可空 默认值
 @param res <#res description#>
 */
-(void)addColumnWithNameSql:(NSString*)nameSql result:(void(^)(BOOL success))res;

/**
 删除字段

 @param columnName 字段名
 @param res <#res description#>
 */
-(void)deleteColumn:(NSString *)columnName result:(void(^)(BOOL success))res;


@end
