//
//  MainCell.m
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import "MainCell.h"

@interface MainCell()



@end

@implementation MainCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpCellUI];
    }
    return self;
}

-(void) setUpCellUI
{
    
    _logoImageView = [UIImageView new];
    [self.contentView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(13);
        make.bottom.mas_equalTo(-13);
        make.width.mas_equalTo(26);
    }];
    
    _nextImageView = [UIImageView new];
    _nextImageView.image = [UIImage imageNamed:@"public_next_identify_image"];
    [self.contentView addSubview:_nextImageView];
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 20));
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    
    _titleLabel = [UILabel new];
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    _titleLabel.textColor = [UIColor colorWithRed:90.0 / 255.0 green:90.0 / 255.0 blue:90.0 / 255.0 alpha:1.0];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(_logoImageView.mas_right).mas_offset(20);
        make.right.mas_equalTo(_nextImageView.mas_left).mas_offset(-20);
    }];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
