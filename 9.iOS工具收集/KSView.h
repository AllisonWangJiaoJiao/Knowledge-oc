//
//  KSView.h
//  UserTwinkleTwinkle
//
//  Created by kangshibiao on 16/10/12.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface KSView : UIView

@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@end
