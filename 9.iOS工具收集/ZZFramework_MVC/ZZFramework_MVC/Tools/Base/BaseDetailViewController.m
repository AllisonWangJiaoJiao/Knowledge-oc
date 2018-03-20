//
//  BaseDetailViewController.m
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import "BaseDetailViewController.h"

@interface BaseDetailViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    self.view.backgroundColor = RGB(220, 220, 220);
    
}
#pragma mark --- 阿门，但愿不会出问题吧 ，手势滑动
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark --- 到上面为手势滑动的

-(void)initNavigation
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB(1, 147, 255)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20.0f],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 44, 44);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"backNav"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(nextBaseGoBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
}
-(void)nextBaseGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
