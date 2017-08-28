//
//  ViewController.m
//  FMDB_Demo
//
//  Created by WanWan. on 2017/7/10.
//  Copyright © 2017年 iamwanwan. All rights reserved.
//

#import "ViewController.h"
#import "UserDBManager.h"
#import "User.h"
#import "UserDetailViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *but_load;
@property (weak, nonatomic) IBOutlet UIButton *but_addSex;
@property (weak, nonatomic) IBOutlet UIButton *but_delSex;

@property (nonatomic, strong) UserDBManager *dbManager;
@property (nonatomic, strong) NSArray<User *> *dataArray;
@end

@implementation ViewController
#pragma mark - get set
-(UserDBManager *)dbManager {
    if (!_dbManager) {
        _dbManager = [[UserDBManager alloc] init];
    }
    return _dbManager;
}
#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表";
    self.navigationController.navigationBar.translucent = NO;
    [self butDelColumnAction:nil];//清除表sex字段（测试字段增删功能）
    self.but_addSex.enabled = YES;
    self.but_delSex.enabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];//显示时候取消cell选中状态
}

//获取数据库数据并且刷新table
-(void)reload {
    __weak typeof(self) wself = self;
    [self.dbManager allDataWithCallBack:^(NSArray<User *> *array) {
        wself.dataArray = array;
        [wself.tableView reloadData];
    }];
}

#pragma mark - butAction
//数据库增加字段
- (IBAction)butAddColumnAction:(UIButton *)sender {
    __weak typeof(self) wself = self;
    //增加性别，默认值2（女）
    [self.dbManager addColumnWithNameSql:@"sex integer DEFAULT 2" result:^(BOOL success) {
        if (success) {
            wself.but_addSex.enabled = NO;
            wself.but_delSex.enabled = YES;
        }
        [wself reload];
    }];
}

//数据库删除字段
- (IBAction)butDelColumnAction:(UIButton *)sender {
    __weak typeof(self) wself = self;
    //删除性别
    [self.dbManager deleteColumn:@"sex" result:^(BOOL success) {
        if (success) {
            wself.but_addSex.enabled = YES;
            wself.but_delSex.enabled = NO;
        }
        [wself reload];
    }];
}

//模拟加载数据
- (IBAction)butLoadAction:(UIButton *)sender {
    User *user = [[User alloc] init];
    user.uId = [self randomUid];
    user.name = [self randomName];
    user.age = [self randomAge];
//    user.sex = [self randomSex];//sql语句 sex 未更新到表
    user.money = [self randomMoney];
    
    User *user1 = [[User alloc] init];
    user1.uId = [self randomUid];
    user1.name = [self randomName];
    user1.age = [self randomAge];
//    user1.sex = [self randomSex];
    user1.money = [self randomMoney];
    
    User *user2 = [[User alloc] init];
    user2.uId = [self randomUid];
    user2.name = [self randomName];
    user2.age = [self randomAge];
//    user2.sex = [self randomSex];
    user2.money = [self randomMoney];
    
    User *user3 = [[User alloc] init];
    user3.uId = [self randomUid];
    user3.name = [self randomName];
    user3.age = [self randomAge];
//    user3.sex = [self randomSex];
    user3.money = [self randomMoney];
    NSArray<User *> *array = @[user, user1, user2, user3];
    __weak typeof(self) wself = self;
    [self.dbManager updateUsers:array result:^(BOOL success) {
        [wself reload];//次处直接再次读取数据库数据显示
//        if (success) {//也可以在插入成功后直接将数据添加到self.dataArray然后显示
//            NSMutableArray *arr = [wself.dataArray mutableCopy];
//            [arr addObjectsFromArray:array];
//            wself.dataArray = [arr copy];
//            [wself.tableView reloadData];
//        }
    }];
}



#pragma mark - tableView delegate、dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    User *user = self.dataArray[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@", user.name];
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"姓名：%@", user.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor blackColor]}];
        NSMutableAttributedString *idString = [[NSMutableAttributedString alloc] initWithString:user.uId attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor grayColor]}];
        [attributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
        [attributedString appendAttributedString:idString];
        cell.textLabel.attributedText = attributedString;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄：%lu 性别：%@", (unsigned long)user.age, user.sexStr];
    }//赋值
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = self.dataArray[indexPath.row];
    UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] init];
    userDetailViewController.user = user;
    [self.navigationController pushViewController:userDetailViewController animated:YES];
}
#pragma mark - 随机值
-(double)randomMoney {
    int m = 0 +  (arc4random() % 50000);
    double money = m/100.0;
    return money;
}

-(NSUInteger)randomSex {
    int sex = 0 +  (arc4random() % 2);
    return sex;
}

-(NSUInteger)randomAge {
    int age = 10 +  (arc4random() % 40);
    return age;
}

-(NSString*)randomName {
    int count = 2 +  (arc4random() % 2);
    NSMutableString *name = [NSMutableString string];
    for (int i = 0; i<count; i++) {
        [name appendString:[self randomCN]];
    }
    return name;
}

-(NSString*)randomCN {//随机汉字
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
    NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
    NSInteger number = (randomH<<8)+randomL;
    NSData *data = [NSData dataWithBytes:&number length:2];
    NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    return string;
}

- (NSString *)randomUid {
    uuid_t uuid;
    uuid_generate(uuid);
    char buffer[37] = {0};
    uuid_unparse_upper(uuid, buffer);
    return [[NSString stringWithUTF8String:buffer] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
