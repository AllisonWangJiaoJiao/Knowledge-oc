//
//  KSView.m
//  UserTwinkleTwinkle
//
//  Created by kangshibiao on 16/10/12.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSView.h"

@implementation KSView

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat )borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    if (cornerRadius > 0) {
        self.layer.masksToBounds = YES;
    }
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

@end
