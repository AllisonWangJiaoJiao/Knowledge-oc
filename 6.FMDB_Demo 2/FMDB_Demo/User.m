//
//  User.m
//  FMDB_Demo
//
//  Created by WanWan. on 2017/7/10.
//  Copyright © 2017年 iamwanwan. All rights reserved.
//

#import "User.h"

@implementation User
-(NSString *)sexStr {
    switch (self.sex) {
        case 1:
            return @"男";
            break;
        case 2:
            return @"女";
            break;
        default:
            return @"未知";
            break;
    }
}
@end
