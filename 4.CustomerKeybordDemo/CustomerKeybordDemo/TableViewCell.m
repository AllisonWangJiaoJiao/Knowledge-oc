//
//  TableViewCell.m
//  CustomerKeybordDemo
//
//  Created by Allison on 2017/8/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "TableViewCell.h"
#import "YFNumberKeyboardView.h"

@interface TableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (nonatomic,strong) YFNumberKeyboardView  *keyboardV;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _contentTF.delegate = self;
    
    self.keyboardV= [YFNumberKeyboardView keyboardView];
    self.keyboardV.frame=  CGRectMake(0, [[UIScreen mainScreen] bounds].size.height , [[UIScreen mainScreen] bounds].size.width, 230);
    _contentTF.inputView = self.keyboardV;
    
}
- (void)setInfo:(NSString*)num content:(NSString *)content{
    _numLabel.text = num;
    _contentTF.text = content;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    self.block(textField.text);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//      self.block(textField.text);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
