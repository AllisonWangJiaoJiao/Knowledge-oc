//
//  TableViewCell.h
//  CustomerKeybordDemo
//
//  Created by Allison on 2017/8/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFNumberKeyboardView.h"

typedef void (^ContentBlock)(NSString *contentStr,NSInteger row);

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (nonatomic,strong) YFNumberKeyboardView  *keyboardV;

@property (nonatomic,assign)NSInteger row;

- (void)setInfo:(NSString*)num content:(NSString *)content;
@property (nonatomic, copy)ContentBlock block;
@end
