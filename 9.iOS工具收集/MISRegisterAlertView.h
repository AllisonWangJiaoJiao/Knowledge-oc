//
//  MISRegisterAlertView.h
//  CQJXT
//
//  Created by isoftstone on 16/7/1.
//  Copyright © 2016年 Eduapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MISRegisterAlertViewDelegate <NSObject>

- (void)touchMsgLoginBtn;
- (void)touchFindPswBtn;
- (void)touchCancelBtn;

@end

@interface MISRegisterAlertView : UIView

@property (nonatomic, assign) id <MISRegisterAlertViewDelegate> delegate;
@end
