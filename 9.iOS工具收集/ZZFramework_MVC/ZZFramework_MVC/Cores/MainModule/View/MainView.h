//
//  MainView.h
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewDelegate <NSObject>

-(void) didSelectActivity;

@end

@interface MainView : UIView

@property (nonatomic, weak)   id<MainViewDelegate>delegate;

@end
