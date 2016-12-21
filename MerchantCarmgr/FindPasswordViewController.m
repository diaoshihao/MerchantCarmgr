//
//  FindPasswordViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/22.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "UIViewController+ShowView.h"
#import "Interface.h"

@interface FindPasswordViewController ()

@property (nonatomic, strong) UITextField *phoneNum;
@property (nonatomic, strong) UITextField *verify;

@property (nonatomic, strong) UIButton *getVerify;

@property (nonatomic, assign) NSUInteger timeout;
@property (nonatomic, strong) NSTimer *downTimer;

@end

@implementation FindPasswordViewController
{
    NSString *uuid;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    
    [self initTextField];
}

- (void)initTextField {
    self.phoneNum = self.usernameField;
    self.phoneNum.placeholder = @"请输入您的手机号";
    self.phoneNum.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNum.rightView = [self getVerfCodeView];
    self.phoneNum.rightViewMode = UITextFieldViewModeAlways;
    
    self.verify = self.passwordField;
    self.verify.placeholder = @"请输入您的短信验证码";
    
    [self verifyButton];
}

//- (void)addButtonToVerify {
//    self.getVerify = [EnterView verifyCodeButton];
//    [self.getVerify addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
//    [self.phoneNum addSubview:self.getVerify];
//    [self.getVerify mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.phoneNum);
//        make.right.mas_equalTo(-20);
//        make.width.mas_equalTo(90);
//        make.height.mas_equalTo(30);
//    }];
//}

- (UIView *)getVerfCodeView {
    self.getVerify = [EnterView verifyCodeButton];
    self.getVerify.frame = CGRectMake(0, 7, 90, 30);
    [self.getVerify addTarget:self action:@selector(sendVerf_code) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    [rightView addSubview:self.getVerify];
    return rightView;
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

//发送验证码
- (void)sendVerf_code {
    if (self.phoneNum.text.length == 0) {
        [self showAlertMessage:@"请输入手机号码"];
        return;
    }
    UIView *progressHUD = [self loading:@"正在发送..."];
    self.allowGesture = NO;//禁止交互和手势
    uuid = [Interface uuid];
    NSArray *verf = [Interface appsendverfcode:self.phoneNum.text type:@"2" uuid:uuid];
    [MyNetworker POST:verf[InterfaceUrl] parameters:verf[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self startTimer];
        } else {
            [self showAlertMessage:@"发送失败！"];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        [self connectError];
    }];
}

- (void)verifyCode:(UIButton *)sender {
    if (self.phoneNum.text.length == 0 || self.verify.text.length == 0) {
        [self showAlertMessage:@"用户名和密码不能为空"];
        return;
    }
    uuid = [Interface uuid];
    NSArray *checkverify = [Interface appcheckverfcode:self.phoneNum.text mobile:self.phoneNum.text verf_code:self.verify.text type:@"2" uuid:uuid];
    [MyNetworker POST:checkverify[InterfaceUrl] parameters:checkverify[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            
        } else {
            
        }
    } failure:^(NSError *error) {
        
    }];
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
