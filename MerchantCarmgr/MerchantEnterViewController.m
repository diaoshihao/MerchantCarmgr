//
//  MerchantEnterViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MerchantEnterViewController.h"
#import "UserProtocolViewController.h"
#import "LeagueParentViewController.h"
#import "UIViewController+ShowView.h"
#import "Interface.h"

@interface MerchantEnterViewController ()

@property (nonatomic, strong) UITextField *phoneNumField;
@property (nonatomic, strong) UITextField *verifyCodeField;
@property (nonatomic, strong) UIView *lastSeparatorView;

@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, strong) NSTimer *downTimer;
@property (nonatomic, strong) UIButton *getVerifyCode;

@property (nonatomic, strong) NSString *uuid;

@end

@implementation MerchantEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setting];
    [self initAndLayoutView];
}

- (void)initAndLayoutView {
    [self addTextField];
    
    [self addButton];
}

//用户协议
- (void)pushToUserProtocol {
    [self.navigationController pushViewController:[[UserProtocolViewController alloc] init] animated:YES];
}

//下一步
- (void)pushToNextStep {
    LeagueParentViewController *leagueParentVC = [[LeagueParentViewController alloc] init];
    [self.navigationController pushViewController:leagueParentVC animated:YES];
}

//timeout
- (void)startTimer {
    self.timeout = 60;
    self.getVerifyCode.enabled = NO;
    self.downTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonState) userInfo:nil repeats:YES];
}

//发送验证码
- (void)sendVerf_code {
    if (self.phoneNumField.text.length == 0) {
        [self showAlertMessage:@"请输入手机号码"];
        return;
    }
    UIView *progressHUD = [self loading:@"正在发送..."];
    self.allowGesture = NO;//禁止交互和手势
    self.uuid = [Interface uuid];
    NSArray *verf = [Interface appsendverfcode:self.phoneNumField.text type:@"0" uuid:self.uuid];
    [MyNetworker POST:verf[InterfaceUrl] parameters:verf[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self startTimer];
        } else if ([responseObject[@"opt_info"] isEqualToString:@"user account is already exist"]) {
            [self showAlertMessage:@"该号码已注册，请登录或修改号码"];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        [self connectError];
    }];
}

//点击发送验证码后按钮变灰
- (void)changeButtonState {
    self.timeout--;
    [self.getVerifyCode setTitle:[NSString stringWithFormat:@"%ld",(long)self.timeout] forState:UIControlStateDisabled];
    [self.getVerifyCode setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.getVerifyCode.layer.borderColor = [UIColor grayColor].CGColor;
    if (self.timeout == 0) {
        self.getVerifyCode.enabled = YES;
        [self.getVerifyCode setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.getVerifyCode.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
        [self.downTimer invalidate];
    }
}

- (void)appregister {
    if (![self allDone]) {
        return;
    }
    UIView *progressHUD = [self loading:@"正在注册..."];
    self.allowGesture = NO;//禁止交互和手势
    NSArray *regist = [Interface mappregister:self.usernameField.text password:self.passwordField.text mobile:self.phoneNumField.text verf_code:self.verifyCodeField.text];
    [MyNetworker POST:regist[InterfaceUrl] parameters:regist[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self pushToNextStep];
        } else if ([responseObject[@"opt_info"] isEqualToString:@"user account is already exist"]) {
            [self showAlertMessage:@"该号码已注册，请勿重复注册"];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        [self connectError];
    }];
}

//填写信息检查
- (BOOL)allDone {
    if (self.usernameField.text.length == 0 || self.passwordField.text.length == 0) {
        [self showAlertMessage:@"用户名和密码不能为空"];
        return NO;
    }
    if (self.verifyCodeField.text.length == 0) {
        [self showAlertMessage:@"请输入验证码"];
        return NO;
    }
    return YES;
}

///////////////////////////////////////////////////////////////////////
- (void)setting {
    self.title = @"入驻";
    self.usernameField.placeholder = @"请输入您的账号";
    self.passwordField.placeholder = @"请输入您的密码";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordField.rightView = [self rightView];
}

- (UIButton *)rightView {
    UIButton *eye = [UIButton buttonWithType:UIButtonTypeCustom];
    eye.frame = CGRectMake(0, 0, 44, 44);
    [eye setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
    [eye setImage:[UIImage imageNamed:@"password_look"] forState:UIControlStateSelected];
    [eye addTarget:self action:@selector(lookPassword:) forControlEvents:UIControlEventTouchUpInside];
    return eye;
}

- (void)lookPassword:(UIButton *)sender {
    self.passwordField.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

///////////////////////////////////////////////////////////////////////

- (UIView *)getVerfCodeView {
    self.getVerifyCode = [EnterView verifyCodeButton];
    self.getVerifyCode.frame = CGRectMake(0, 7, 90, 30);
    [self.getVerifyCode addTarget:self action:@selector(sendVerf_code) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    [rightView addSubview:self.getVerifyCode];
    return rightView;
}

- (void)addTextField {
    self.phoneNumField = [Public twoSpaceTextField:@"请输入您的手机号"];
    self.phoneNumField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumField.rightViewMode = UITextFieldViewModeAlways;
    self.phoneNumField.rightView = [self getVerfCodeView];
    [self.view addSubview:self.phoneNumField];
    [self.phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //输入框分割线
    UIView *textFieldSeparator = [self separatorViewWithHeight:[DefineValue pixHeight] constraintsView:self.phoneNumField superView:self.view];
    
    self.verifyCodeField = [Public twoSpaceTextField:@"请输入您的短信验证码"];
    self.verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.verifyCodeField];
    [self.verifyCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textFieldSeparator.mas_bottom).offset([UIScreen mainScreen].scale);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)addButton {
    //第二条分割线
    self.lastSeparatorView = [self separatorViewWithHeight:7 constraintsView:self.verifyCodeField superView:self.view];
    
    UIButton *enterButton = [Public loginTypeButton:@"入驻"];
    [enterButton addTarget:self action:@selector(appregister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];
    [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lastSeparatorView.mas_bottom).mas_equalTo(60);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"已选择"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(enterButton.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.width.and.height.mas_equalTo(20);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我已阅读并同意";
    label.font = [DefineValue font12];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(15);
        make.centerY.mas_equalTo(imageView);
        make.height.mas_equalTo(imageView.mas_height);
    }];
    
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeButton setTitle:@"《易务车宝平台用户协议》" forState:UIControlStateNormal];
    agreeButton.titleLabel.font = [DefineValue font12];
    [agreeButton setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    [agreeButton addTarget:self action:@selector(pushToUserProtocol) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeButton];
    [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(0);
        make.centerY.mas_equalTo(imageView);
        make.height.mas_equalTo(imageView.mas_height);
    }];
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
