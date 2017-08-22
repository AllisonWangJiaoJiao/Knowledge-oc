//
//  YFNumberKeyboardView.m
//  RYNumberKeyboardDemo
//
//  Created by Allison on 2017/8/16.
//  Copyright © 2017年 Resory. All rights reserved.
//

#import "YFNumberKeyboardView.h"

@interface YFNumberKeyboardView ()


@end

@implementation YFNumberKeyboardView

+ (instancetype)keyboardView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YFNumberKeyboardView" owner:nil options:nil] lastObject];
}

- (void)dismissKeyboardView{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height , [[UIScreen mainScreen] bounds].size.width, 250);
    }];
}
- (void)showPopKeyboardView{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 250, [[UIScreen mainScreen] bounds].size.width, 250);
    }];
}

//ToolBar上按钮的点击事件
/// 上 -- tag:100   下 -- tag:101   Done -- tag:102
- (IBAction)toolBarClick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didToolBarClick:)]) {
        [self.delegate didToolBarClick:sender.tag];
    }
    
}




//按钮的点击事件
/*
 0 -- tag:1000   1 -- tag:1001   2 -- tag:1002
 3 -- tag:1003   4 -- tag:1004   5 -- tag:1005
 6 -- tag:1006   7 -- tag:1007   8 -- tag:1008
 9 -- tag:1009   00 -- tag:1010   x -- tag:1011
 确定 -- tag:1012 F -- tag:1013   E -- tag:1014
 D -- tag:1015   C -- tag:1016   B -- tag:1017
 A -- tag:1018
 */
- (IBAction)numberKeyboardViewAction:(UIButton *)sender {

    NSInteger tag = sender.tag ;
    switch (tag) {
        case 1010:
            // 00
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"00"];
            }
            break;
        case 1011:
            // 删除
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedDelete)]) {
                [self.delegate didTouchedDelete];
            }
            break;
        case 1012:
            // 确定
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedConfirm)]) {
                [self.delegate didTouchedConfirm];
            }
            break;
        case 1013:
            // F
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"F"];
            }
            break;
        case 1014:
            // E
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"E"];
            }
            break;
        case 1015:
            // D
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"D"];
            }
            break;
        case 1016:
            // C
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"C"];
            }
            break;
        case 1017:
            // B
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"B"];
            }
            break;
        case 1018:
            // A
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:@"A"];
            }
            break;
            
        default:
        {
            // 数字
            NSString *numText = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchedNumberKey:)]) {
                [self.delegate didTouchedNumberKey:numText];
            }
        }
            break;
    }
    
    
    
    
}


@end
