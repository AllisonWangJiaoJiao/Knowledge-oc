//
//  ViewController.m
//  CustomerKeybordDemo
//
//  Created by Allison on 2017/8/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "ViewController.h"
#import "YFNumberKeyboardView.h"
@interface ViewController () <YFNumberKeyboardViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)YFNumberKeyboardView *keyboardView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;


@end

@implementation ViewController

-(YFNumberKeyboardView *)keyboardView{
    if (!_keyboardView) {
        _keyboardView =[YFNumberKeyboardView keyboardView];
        _keyboardView.frame =  CGRectMake(0, [[UIScreen mainScreen] bounds].size.height , [[UIScreen mainScreen] bounds].size.width, 250);
        _keyboardView.delegate = self;
    }
    return _keyboardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _textFiled.delegate = self;
//    [self.view addSubview:self.keyboardView];

}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_keyboardView showPopKeyboardView];
}

#pragma mark -<YFNumberKeyboardViewDelegate>
-(void)didTouchedNumberKey:(NSString *)string{
    NSLog(@"%@",string);
}

//点击
-(void)didTouchedDelete{
    
}

-(void)didTouchedConfirm{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
//    [_keyboardView showPopKeyboardView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
