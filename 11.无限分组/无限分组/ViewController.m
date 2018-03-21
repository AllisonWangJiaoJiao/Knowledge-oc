//
//  ViewController.m
//  无限分组
//
//  Created by XianHong zhang on 2018/3/14.
//  Copyright © 2018年 XianHong zhang. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//原始数据
@property (nonatomic, copy) NSArray *orgeArr;
//数据字典
@property (nonatomic, copy) NSMutableDictionary *dataDic;
//显示的数据
@property (nonatomic,copy) NSMutableArray *showArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //live 层级,为了拍版
    _orgeArr = @[@{@"p_id":@"0",@"id":@"1.0",@"live":@"1"},
                 @{@"p_id":@"0",@"id":@"2.0",@"live":@"1"},
                 @{@"p_id":@"0",@"id":@"3.0",@"live":@"1"},
                 @{@"p_id":@"0",@"id":@"4.0",@"live":@"1"},
                 @{@"p_id":@"1.0",@"id":@"1.1",@"live":@"2"},
                 @{@"p_id":@"1.0",@"id":@"1.2",@"live":@"2"},
                 @{@"p_id":@"2.0",@"id":@"2.1",@"live":@"2"},
                 @{@"p_id":@"4.0",@"id":@"4.1",@"live":@"2"},
                 @{@"p_id":@"1.1",@"id":@"1.1.1",@"live":@"3"},
                 @{@"p_id":@"1.1",@"id":@"1.1.2",@"live":@"3"},
                 @{@"p_id":@"1.1.1",@"id":@"1.1.1.1",@"live":@"4"},
                 @{@"p_id":@"1.1.1.1",@"id":@"1.1.1.1.1",@"live":@"5"}];
    _dataDic = [[NSMutableDictionary alloc] init];
    _showArr = [[NSMutableArray alloc] init];
    [_orgeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *p_id = obj[@"p_id"];
//        NSString *s_id = obj[@"id"];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if (_dataDic[p_id]) {
            [arr addObjectsFromArray:_dataDic[p_id]];
        }
        [arr addObject:obj];
        _dataDic[p_id] = arr;
        if (p_id.integerValue == 0) {
            [_showArr addObject:obj];
        }
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _showArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListTableViewCell" owner:nil options:nil] lastObject];
    }
    NSDictionary *dic = _showArr[indexPath.row];
    NSInteger live = [dic[@"live"] integerValue];
    NSString *space = @"";
    for (int i = 0; i < live; i ++) {
        space = [NSString stringWithFormat:@"%@  ",space];
    }
    cell.txtLabel.text = [NSString stringWithFormat:@"%@%@",space,dic[@"id"]];
    cell.showBtn.tag = indexPath.row;
    [cell.showBtn addTarget:self action:@selector(showBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //判断是否显示展开收起按钮
    [self isShowBtnWithCell:cell];
    
    return cell;
}

//展开收起按钮的点击方法
- (void)showBtnAction:(UIButton *)btn{
    //只要此方法走了，就代表有展开收起按钮
    NSInteger btnTag = btn.tag;
    NSDictionary *dic = _showArr[btnTag];
    NSString *s_id = dic[@"id"];
    NSArray *arr = _dataDic[s_id];
    if ([_showArr containsObject:arr.firstObject]) {
        //此时是展开状态,要全部删除次级数据，变为收起状态
        //id为次级数据的判断依据
        [self delegateShowDataWithDic:dic];
        
    }else{
        //此时是收起状态
        for (int i = 0; i < arr.count; i ++) {
            NSDictionary *obj = arr[i];
            if (![_showArr containsObject:obj]) {
                [_showArr insertObject:obj atIndex:btnTag+i+1];
            }
            
        }
    }
    [_tableView reloadData];
}

//判断cell上是否有展开收起按钮
- (void)isShowBtnWithCell:(ListTableViewCell *)cell{
    NSInteger btnTag = cell.showBtn.tag;
    NSDictionary *dic = _showArr[btnTag];
    NSString *s_id = dic[@"id"];
    NSArray *arr = _dataDic[s_id];
    if (arr && arr.count>0) {
        cell.showBtn.hidden = NO;
        //如果有展开收起按钮，判断是展开还是收起
        if ([_showArr containsObject:arr.firstObject]) {
//            [cell.showBtn setTitle:@"收起" forState:UIControlStateNormal];
            [cell.showBtn setImage:[UIImage imageNamed:@"delet"] forState:UIControlStateNormal];
        }else{
//            [cell.showBtn setTitle:@"展开" forState:UIControlStateNormal];
            [cell.showBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        }
    }else{
        [cell.showBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
//        [cell.showBtn setTitle:@"展开" forState:UIControlStateNormal];
        cell.showBtn.hidden = YES;
    }
    
}
//递归删除所有展开的数据
- (void)delegateShowDataWithDic:(NSDictionary *)dic{
    //当前节点的id为子节点的p_id
    NSString *s_id = dic[@"id"];
    NSArray *arr = _dataDic[s_id];
    if ([_showArr containsObject:arr.firstObject]) {
        //说明还有次级数据,继续递归
        [self delegateShowDataWithDic:arr.firstObject];
        
        for (NSInteger i = _showArr.count-1; i >= 0; i --) {
            NSDictionary *delDic = _showArr[i];
            //如果子节点的p_id和当前节点的id相同，则表示子节点需要删除
            if ([delDic[@"p_id"] isEqualToString:s_id]) {
                [_showArr removeObject:delDic];
            }
        }
    }
}

@end
