//
//  TableViewCell.m
//  CustomerKeybordDemo
//
//  Created by Allison on 2017/8/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
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

#pragma mark -<UITextFieldDelegate>
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"%ld",(long)self.row);
    self.block(textField.text, self.row);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%ld",(long)self.row);
    self.block(textField.text, self.row);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
