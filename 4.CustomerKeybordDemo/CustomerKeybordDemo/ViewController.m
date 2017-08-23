//
//  ViewController.m
//  CustomerKeybordDemo
//
//  Created by Allison on 2017/8/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "ViewController.h"
#import "YFNumberKeyboardView.h"
#import "TableViewCell.h"

@interface ViewController () <YFNumberKeyboardViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,YFNumberKeyboardViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)NSInteger currentRow;//记录行
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    //[_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.row = indexPath.row;
    NSString *num = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSString *contentStr = _dataArray[indexPath.row];
    [cell setInfo:num content:contentStr];
    cell.block = ^(NSString *contentStr, NSInteger row) {
        self.currentRow = row;

    NSMutableArray *temArray = [self.dataArray mutableCopy];
    [temArray replaceObjectAtIndex:_currentRow withObject:contentStr];
    self.dataArray = temArray;
    NSLog(@"%@",self.dataArray);
  
    };
    cell.keyboardV.delegate = self;

    return cell;
}

#pragma mark --

#pragma mark -<YFNumberKeyboardViewDelegate>
//字母数字
-(void)didTouchedNumberKey:(NSString *)string{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    TableViewCell *cell = [_tableView cellForRowAtIndexPath:indexP];
    [cell.contentTF insertText:string];
    
}

//删除
-(void)didTouchedDelete{
    
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    TableViewCell *cell = [_tableView cellForRowAtIndexPath:indexP];
    [cell.contentTF deleteBackward];
}
//确定
-(void)didTouchedConfirm{
    
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:_currentRow inSection:0];
    TableViewCell *cell = [_tableView cellForRowAtIndexPath:indexP];
    [cell.contentTF resignFirstResponder];
}


@end
