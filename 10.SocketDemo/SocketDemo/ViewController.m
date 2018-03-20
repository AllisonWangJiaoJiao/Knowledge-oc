//
//  ViewController.m
//  SocketDemo
//
//  Created by Allison on 2018/3/13.
//  Copyright © 2018年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import "ViewController.h"
#import "SocketManager.h"

@interface ViewController ()
- (IBAction)connectClick:(UIButton *)sender;
- (IBAction)disconnectClick:(UIButton *)sender;
- (IBAction)sendClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *sendTextFeild;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)connectClick:(UIButton *)sender {
    BOOL isConnect = [[SocketManager share] connect];
    NSLog(@"%d",isConnect);
}

- (IBAction)disconnectClick:(UIButton *)sender {
    [[SocketManager share] disConnect];
}

- (IBAction)sendClick:(UIButton *)sender {
    if (_sendTextFeild.text.length == 0) {
        return;
    }
    [[SocketManager share] sendMessage:_sendTextFeild.text];
}
@end
