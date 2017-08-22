//
//  YFNumberKeyboardView.h
//  RYNumberKeyboardDemo
//
//  Created by Allison on 2017/8/16.
//  Copyright © 2017年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFNumberKeyboardViewDelegate <NSObject>

@optional
- (void)didTouchedNumberKey:(NSString*)string;
- (void)didTouchedDelete;
- (void)didTouchedConfirm;
@end

@interface YFNumberKeyboardView : UIView
@property (nonatomic,weak) id<YFNumberKeyboardViewDelegate> delegate;

- (void)dismissKeyboardView;
- (void)showPopKeyboardView;

+ (instancetype)keyboardView;
@end
