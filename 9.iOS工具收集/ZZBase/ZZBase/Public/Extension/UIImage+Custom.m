//
//  UIView+Rect.h
//  gywangluo
//
//  Created by yuan on 14/10/30.
//  Copyright (c) 2014年 euc. All rights reserved.
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
