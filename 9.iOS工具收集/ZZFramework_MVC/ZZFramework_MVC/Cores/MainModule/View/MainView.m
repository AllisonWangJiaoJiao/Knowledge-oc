//
//  MainView.m
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import "MainView.h"
#import "MainCell.h"

@interface MainView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table_view;

@end

@implementation MainView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self makeMainViewUI];
        
    }
    return self;
}

-(void) makeMainViewUI
{
    _table_view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table_view.dataSource = self;
    _table_view.delegate = self;
    _table_view.backgroundColor = CLEARCOLOR;
    [self addSubview:_table_view];
    [_table_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
}


#pragma mark ```dataSource```
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    MainCell *voteCell = [tableView dequeueReusableCellWithIdentifier:@"VoteCell"];
                    if (!voteCell) {
                        voteCell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VoteCell"];
                    }
                    voteCell.logoImageView.image = [UIImage imageNamed:@"find_vote"];
                    voteCell.titleLabel.text = @"投票";
                    return voteCell;
                }
                    break;
                    
                case 1:
                {
                    MainCell *activityCell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
                    if (!activityCell) {
                        activityCell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityCell"];
                    }
                    activityCell.logoImageView.image = [UIImage imageNamed:@"find_activity"];
                    activityCell.titleLabel.text = @"活动";
                    return activityCell;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            MainCell *featuresCell = [tableView dequeueReusableCellWithIdentifier:@"FeaturesCell"];
            if (!featuresCell) {
                featuresCell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeaturesCell"];
            }
            featuresCell.logoImageView.image = [UIImage imageNamed:@"find_features"];
            featuresCell.titleLabel.text = @"专题";
            return featuresCell;
        }
            break;
            
        case 2:
        {
            MainCell *gameCell = [tableView dequeueReusableCellWithIdentifier:@"GameCell"];
            if (!gameCell) {
                gameCell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GameCell"];
            }
            gameCell.logoImageView.image = [UIImage imageNamed:@"find_game"];
            gameCell.titleLabel.text = @"游戏中心";
            return gameCell;
        }
            break;
            
        default:
            break;
    }
    return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
            break;
            
        case 1:
            return 10;
            break;
            
        case 2:
            return 10;
            break;
            
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                if ([self.delegate respondsToSelector:@selector(didSelectActivity)]) {
                    [self.delegate didSelectActivity];
                }
            }
        }
            break;
            
        case 1:
        {
            
        }
            break;
            
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
