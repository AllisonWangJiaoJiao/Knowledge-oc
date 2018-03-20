//
//  MainController.m
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import "MainController.h"
#import "MainView.h"
#import "ActivityListController.h"

@interface MainController ()<MainViewDelegate>

@property (nonnull, nonatomic , strong) MainView *mainView;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发现";
    
    
    [self makeMainViewUI];
    
}

-(void) makeMainViewUI
{
    _mainView = [[MainView alloc]init];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}

#pragma mark ```MainViewDelegate```
-(void)didSelectActivity
{
    ActivityListController *activityListController = [[ActivityListController alloc]init];
    [self.navigationController pushViewController:activityListController animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
