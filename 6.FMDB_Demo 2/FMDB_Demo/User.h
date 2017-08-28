//
//  User.h
//  FMDB_Demo
//
//  Created by WanWan. on 2017/7/10.
//  Copyright © 2017年 iamwanwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *uId;//用户编号
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, assign) NSUInteger age;//年龄
@property (nonatomic, assign) double money;//充值金额
@property (nonatomic, assign) NSUInteger sex;//0(或其它) 未知， 1男， 2女
@property (nonatomic, readonly) NSString *sexStr;//sex转中文名称
@end
