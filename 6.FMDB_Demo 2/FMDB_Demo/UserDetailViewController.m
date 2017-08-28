//
//  UserDetailViewController.m
//  FMDB_Demo
//
//  Created by WanWan. on 2017/7/11.
//  Copyright © 2017年 iamwanwan. All rights reserved.
//

#import "UserDetailViewController.h"
#import "Masonry.h"
#import "User.h"

@interface UserDetailViewController ()
@property (nonatomic, strong) UILabel *lab_name;
@property (nonatomic, strong) UILabel *lab_uId;
@property (nonatomic, strong) UILabel *lab_sex;
@property (nonatomic, strong) UILabel *lab_money;
@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"详情";
    [self createSubviews];
    [self displayData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
//显示数据赋值
-(void)displayData {
//    self.title = self.user.name;
    self.lab_name.text = self.user.name;
    NSMutableAttributedString *uId = [[NSMutableAttributedString alloc] initWithString:@"编号：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *idString = [[NSMutableAttributedString alloc] initWithString:self.user.uId attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [uId appendAttributedString:idString];
    self.lab_uId.attributedText = uId;
    self.lab_sex.text = [NSString stringWithFormat:@"性别：%@", self.user.sexStr];
    self.lab_money.text = [NSString stringWithFormat:@"充值金额：%.2f元", self.user.money];
}

//创建子视图，布局
-(void)createSubviews {
    __weak typeof(self) wself = self;
    self.lab_name = [[UILabel alloc] init];
    self.lab_name.textAlignment = NSTextAlignmentCenter;
    self.lab_name.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.lab_name];
    self.lab_uId = [[UILabel alloc] init];
    self.lab_uId.textAlignment = NSTextAlignmentCenter;
    self.lab_uId.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.lab_uId];
    self.lab_sex = [[UILabel alloc] init];
    self.lab_sex.textAlignment = NSTextAlignmentCenter;
    self.lab_sex.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.lab_sex];
    self.lab_money = [[UILabel alloc] init];
    self.lab_money.textAlignment = NSTextAlignmentCenter;
    self.lab_money.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.lab_money];
    
    [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.view);
        make.left.equalTo(wself.view);
        make.right.equalTo(wself.view);
        make.height.equalTo(@(100));
    }];
    
    [self.lab_uId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.lab_name.mas_bottom);
        make.left.equalTo(wself.lab_name);
        make.right.equalTo(wself.lab_name);
        make.height.equalTo(@(30));
    }];
    
    [self.lab_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.lab_uId.mas_bottom);
        make.left.equalTo(wself.lab_name);
        make.right.equalTo(wself.lab_money.mas_left);
        make.width.equalTo(wself.lab_money.mas_width);
        make.height.equalTo(@(30));
    }];
    [self.lab_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.lab_uId.mas_bottom);
        make.left.equalTo(wself.lab_sex.mas_right);
        make.right.equalTo(wself.lab_name);
        make.width.equalTo(wself.lab_sex.mas_width);
        make.height.equalTo(@(30));
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
