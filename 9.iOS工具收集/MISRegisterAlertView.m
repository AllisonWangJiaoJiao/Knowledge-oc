//
//  MISRegisterAlertView.m
//  CQJXT
//
//  Created by isoftstone on 16/7/1.
//  Copyright © 2016年 Eduapp. All rights reserved.
//

#import "MISRegisterAlertView.h"
#import "LGlobalConstants.h"

#define ALERT_WIDTH SCREEN_WIDTH*5/7

@interface MISRegisterAlertView()

@property (nonatomic, strong) UIImageView *alertImgView;
@property (nonatomic, strong) UILabel   *titileL;
@property (nonatomic, strong) UILabel   *contentL;
@property (nonatomic, strong) UIButton  *msgLoginBtn;
@property (nonatomic, strong) UIButton  *findPswBtn;
@property (nonatomic, strong) UIView    *seperateHV;
@property (nonatomic, strong) UIView    *seperateVV;
@property (nonatomic, assign) float     alert_H;
@property (nonatomic, strong) UIButton  *cancelBtn;


@end


@implementation MISRegisterAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    
    [self addViews];
    [self layoutViews];
    
    return self;
}

- (void)addViews
{
    [self addSubview:self.alertImgView];
    
    [_alertImgView addSubview:self.titileL];
    [_alertImgView addSubview:self.contentL];
    [_alertImgView addSubview:self.msgLoginBtn];
    [_alertImgView addSubview:self.findPswBtn];
    [_alertImgView addSubview:self.seperateHV];
    [_alertImgView addSubview:self.seperateVV];
    [_alertImgView addSubview:self.cancelBtn];
}

- (void)layoutViews
{
    [_alertImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ALERT_WIDTH);
       
        make.height.mas_equalTo(170);
    }];
    
    [_titileL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_alertImgView);
        make.top.equalTo(_alertImgView.mas_top).offset(15);
        make.height.mas_equalTo(60);
    }];
    
    [_msgLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.equalTo(_alertImgView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(ALERT_WIDTH/2);
    }];
    
    [_findPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.right.equalTo(_alertImgView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(ALERT_WIDTH/2);
        make.left.equalTo(_msgLoginBtn.mas_right);
    }];
    
    [_seperateHV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_alertImgView);
        make.bottom.equalTo(_findPswBtn.mas_top);
        make.height.mas_equalTo(1);
    }];
    
    [_seperateVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(_findPswBtn);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(1);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertImgView).offset(10);
        make.bottom.equalTo(_msgLoginBtn).offset(-10);
        make.left.equalTo(_alertImgView).offset(20);
        make.right.equalTo(_alertImgView).offset(-10);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_alertImgView).offset(-2);
        make.top.equalTo(_alertImgView).offset(-5);
        make.size.equalTo(@50);
    }];
    
}


- (UIImageView *)alertImgView
{
    if (!_alertImgView) {
        _alertImgView = [[UIImageView alloc] init];
       
        _alertImgView.image = [UIImage imageNamed:@"background.png"];
        _alertImgView.userInteractionEnabled = YES;
    }
    return _alertImgView;
}

- (UILabel *)titileL
{
    if (!_titileL) {
        _titileL = [[UILabel alloc]init];
        _titileL.text = @"您已经是和教育用户";
        _titileL.textAlignment = NSTextAlignmentCenter;
    }
    return _titileL;
}

- (UILabel *)contentL
{
    if (!_contentL) {
        _contentL = [[UILabel alloc]init];
        _contentL.text = @"可以通过短信验证码登录,也可以选择找回密码";
        _contentL.numberOfLines = 0;
    }
    return _contentL;
}

- (UIButton *)msgLoginBtn
{
    if (!_msgLoginBtn) {
        _msgLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_msgLoginBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_msgLoginBtn addTarget:self action:@selector(msgLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgLoginBtn;
}

- (UIButton *)findPswBtn
{
    if (!_findPswBtn) {
        _findPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_findPswBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_findPswBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [_findPswBtn addTarget:self action:@selector(findPswBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findPswBtn;
}

- (UIView *)seperateHV
{
    if (!_seperateHV) {
        _seperateHV = [[UIView alloc]init];
        _seperateHV.backgroundColor = [UIColor redColor];
    }
    return _seperateHV;
}

- (UIView *)seperateVV
{
    if (!_seperateVV) {
        _seperateVV = [[UIView alloc]init];
        _seperateVV.backgroundColor = [UIColor yellowColor];
    }
    return _seperateVV;
}

- (UIButton *)cancelBtn{
    
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage: [UIImage imageNamed:@"background.png"]forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

#pragma mark - 短信验证 && 找回密码
- (void)msgLoginBtnClicked:(UIButton *)btn{
    
    [_delegate touchMsgLoginBtn];
    [self removeFromSuperview];
    
}

- (void)findPswBtnClicked:(UIButton *)btn{
    
    [_delegate touchFindPswBtn];
    [self removeFromSuperview];
    
}

- (void)cancelBtnClicked:(UIButton *)btn{
    
    [_delegate touchCancelBtn];
    [self removeFromSuperview];
}
@end
