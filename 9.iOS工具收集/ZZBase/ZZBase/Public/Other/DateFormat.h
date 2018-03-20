//
//  DateFormat.h
//  TTD
//
//  Created by Yuan on 16/1/12.
//  Copyright © 2016年 EUC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormat : NSObject

/*
 *   返回值为年-月-日,例如 2016-01-01
 */
+(NSString *)resultDateOfyyyyMMdd:(NSString *)date;

/*
 *   返回值为年-月-日 时:分 例如 2016-01-01 8:00
 */
+(NSString *)resultDateOfyyyyMMddHHmm:(NSString *)date;

/*
 *   获取当前时间精确到秒
 */
+(NSString *)getNowDataOfyyyMMddHHmmss;


@end
