//
//  DateFormat.m
//  TTD
//
//  Created by Yuan on 16/1/12.
//  Copyright © 2016年 EUC. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat

+(NSString *)resultDateOfyyyyMMdd:(NSString *)date
{
    NSString *timeStr = date;
    NSTimeInterval timeInterval = [timeStr doubleValue];
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
    [resultFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [resultFormatter stringFromDate:pubDate];
    
    return time;
}

+(NSString *)resultDateOfyyyyMMddHHmm:(NSString *)date
{
    NSString *timeStr = date;
    NSTimeInterval timeInterval = [timeStr doubleValue];
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
    [resultFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *time = [resultFormatter stringFromDate:pubDate];
    
    return time;
}

+(NSString *)getNowDataOfyyyMMddHHmmss
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate date]];
    
    return nowTimeStr;
}



@end
