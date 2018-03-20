//
//  BaseViewController.m
//  TTD
//
//  Created by Yuan on 15/11/9.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupBackItemUI];
}

-(void)setupBackItemUI
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];
    UIButton *back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame = CGRectMake(0, 0, 45, 44);
    [back_btn setBackgroundImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    [back_btn setBackgroundImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateHighlighted];
    [back_btn addTarget:self action:@selector(backItemMethod) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:back_btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bg];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (SYSTEM_VERSION > 7.0) {
        //如果系统版本大于 7.0，则支持手势滑动返回
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;

    }
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


-(void)backItemMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
