//
//  FindPasswordViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/22.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController ()

@property (nonatomic, strong) UITextField *phoneNum;
@property (nonatomic, strong) UITextField *verify;

@property (nonatomic, strong) UIButton *getVerify;

@property (nonatomic, assign) NSUInteger timeout;
@property (nonatomic, strong) NSTimer *downTimer;

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    
    [self initTextField];
}

- (void)initTextField {
    self.phoneNum = self.usernameField;
    self.phoneNum.placeholder = @"请输入您的手机号";
    self.verify = self.passwordField;
    self.verify.placeholder = @"请输入您的短信验证码";
    
    [self addButtonToVerify];
    [self verifyButton];
}

- (void)addButtonToVerify {
    self.getVerify = [EnterView verifyCodeButton];
    [self.getVerify addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneNum addSubview:self.getVerify];
    [self.getVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneNum);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
}

- (void)verifyButton {
    UIButton *button = [Public loginTypeButton:@"验证"];
    [button addTarget:self action:@selector(verifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).mas_equalTo(60);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)verifyCode:(UIButton *)sender {
    sender.enabled = NO;
}

- (void)startTimer {
    self.timeout = 60;
    self.getVerify.enabled = NO;
    self.downTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
}

- (void)changeTime {
    self.timeout--;
    [self.getVerify setTitle:[NSString stringWithFormat:@"%lu",(long)self.timeout] forState:UIControlStateNormal];
    [self.getVerify setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.getVerify.layer.borderColor = [UIColor grayColor].CGColor;
    if (self.timeout == 0) {
        self.getVerify.enabled = YES;
        [self.getVerify setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.getVerify.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
        [self.downTimer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
