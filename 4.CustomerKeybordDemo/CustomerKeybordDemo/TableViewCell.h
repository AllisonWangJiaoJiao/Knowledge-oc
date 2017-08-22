//
//  TableViewCell.h
//  CustomerKeybordDemo
//
//  Created by Allison on 2017/8/22.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ContentBlock)(NSString *contentStr);

@interface TableViewCell : UITableViewCell
- (void)setInfo:(NSString*)num content:(NSString *)content;
@property (nonatomic, copy)ContentBlock block;
@end
