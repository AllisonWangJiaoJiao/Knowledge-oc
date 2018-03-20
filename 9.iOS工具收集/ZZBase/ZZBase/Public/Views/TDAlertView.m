//
//  TDAlertView.m
//  TTD
//
//  Created by Yuan on 15/11/9.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import "TDAlertView.h"

@implementation TDAlertView

+(TDAlertView *)sharedAlertView
{
    static TDAlertView *alertView = nil;
    if (alertView == nil) {
        alertView = [[TDAlertView alloc]init];
    }
    return alertView;
}

@end
