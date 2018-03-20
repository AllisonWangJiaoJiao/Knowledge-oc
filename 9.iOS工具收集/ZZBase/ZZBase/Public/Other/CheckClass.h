//
//  CheckClass.h
//  TTD
//
//  Created by Yuan on 15/12/8.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckClass : NSObject

/***
 *   检验是否为正确的手机号码
 *   参数为任意字符串，传入任意字符串参数及可返回BOOL类型
 ***/
+(BOOL)checkIsPhone:(NSString *)mobileNum;

/***
 *   检验是否为正确的邮箱
 *   参数为任意字符串，传入任意字符串参数及可返回BOOL类型
 ***/
+(BOOL)checkIsEmail:(NSString *)email;
@end
