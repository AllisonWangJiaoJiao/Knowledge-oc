//
//  ViewController.m
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "ViewController.h"
#import "RYNumberKeyboard.h"
#import "UITextField+RYNumberKeyboard.h"
#import "YFNumberKeyboardView.h"

@interface ViewController ()<YFNumberKeyboardViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UITextField *textFiledTwo;
@property (weak, nonatomic) IBOutlet UITextField *textFiledThree;
@property (nonatomic,strong) YFNumberKeyboardView *keyboardView;
@property (weak, nonatomic) IBOutlet UITextField *textTextFiled;

@end

@implementation ViewController

-(YFNumberKeyboardView *)keyboardView{
    if (!_keyboardView) {
        _keyboardView = [YFNumberKeyboardView keyboardView];
         _keyboardView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height , [[UIScreen mainScreen] bounds].size.width, 250);
        _keyboardView.delegate = self;
    }
    return _keyboardView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textTextFiled.delegate = self;
    [self.view addSubview:self.keyboardView];
    
  
    
    self.textFiled.ry_inputType = RYIntInputType;
    self.textFiledTwo.ry_inputType = RYIDCardInputType;
    self.textFiledThree.ry_inputType = RYFloatInputType;
    
    self.textFiled.ry_interval = 4;
    self.textFiledTwo.ry_interval = 6;
    
    self.textFiled.ry_inputAccessoryText = @"请输入银行卡号";
    self.textFiledTwo.ry_inputAccessoryText = @"请输入身份证号";

}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"%@",textField.text);
    //弹出输入框
    [_keyboardView showPopKeyboardView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [_keyboardView dismissKeyboardView];
}

#pragma mark - YFNumberKeyboardViewDelegate Method
//字母数字
- (void)didTouchedNumberKey:(NSString*)string{
     [self.textTextFiled insertText:string];
}
//删除
- (void)didTouchedDelete{
    [self.textTextFiled deleteBackward];
}
//确定
- (void)didTouchedConfirm{
    [self.textTextFiled resignFirstResponder];
    [_keyboardView dismissKeyboardView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
