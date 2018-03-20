//
//  MainView.m
//  ZZBase
//
//  Created by 袁亮 on 16/6/30.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import "MainView.h"

@implementation MainView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeMainViewUI];
        
    }
    return self;
}

-(void) makeMainViewUI
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:button];
}

@end
