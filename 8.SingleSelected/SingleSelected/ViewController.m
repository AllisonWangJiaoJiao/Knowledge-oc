//
//  ViewController.m
//  SingleSelected
//
//  Created by Allison on 2017/9/25.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *problemBut1;
@property (weak, nonatomic) IBOutlet UIButton *problemBut2;
@property (weak, nonatomic) IBOutlet UIButton *problemBut3;
@property (weak, nonatomic) IBOutlet UIButton *problemBut4;

@end

@implementation ViewController

- (IBAction)singleClick:(UIButton *)sender {
    
      [self problemClassification:sender];
}

- (void)problemClassification:(UIButton *)btn{
    [self butLayer:_problemBut1 isUse:true];
    [self butLayer:_problemBut2 isUse:true];
    [self butLayer:_problemBut3 isUse:true];
    [self butLayer:_problemBut4 isUse:true];
    
    [self butLayer:btn isUse:false];
    
}


- (void)butLayer:(UIButton *)btn isUse:(BOOL)isuse{
    
    if (isuse) {
        btn.backgroundColor = [UIColor greenColor];
        
    }else{
        btn.backgroundColor = [UIColor redColor];
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
