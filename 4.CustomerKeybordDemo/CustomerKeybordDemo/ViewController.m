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

@interface ViewController () <YFNumberKeyboardViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign)NSInteger  selectedRow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _selectedRow = 0;
//    _textFiled.delegate = self;
//    [self.view addSubview:self.keyboardView];

    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
     [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

#pragma mark - <UITextFieldDelegate>
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_keyboardView showPopKeyboardView];
//}

#pragma mark -<YFNumberKeyboardViewDelegate>
//字母数字
-(void)didTouchedNumberKey:(NSString *)string{
//    [self.textFiled insertText:string];

}

//删除
-(void)didTouchedDelete{
//    [self.textFiled deleteBackward];

}
//确定
-(void)didTouchedConfirm{
//    [self.textFiled resignFirstResponder];
}

//ToolBarClick
- (void)didToolBarClick:(NSInteger)sender{
    if (sender == 100) {//向上
        NSLog(@"向上");
        
    }else if (sender == 101){//向下
        NSLog(@"向下");
//        [_textFiled becomeFirstResponder ];
        
    }else{//Done
        NSLog(@"Done");
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}

#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedRow = indexPath.row;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    NSString *num = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [cell setInfo:num content:@""];
//    cell.block = ^(NSString *contentStr) {
//        NSLog(@"%@",contentStr);
//        [_keyboardView showPopKeyboardView];
//    };
    return cell;
    
}

@end
