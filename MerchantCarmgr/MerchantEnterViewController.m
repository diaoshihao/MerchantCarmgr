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

@interface MerchantEnterViewController ()

@property (nonatomic, strong) UITextField *phoneNumField;
@property (nonatomic, strong) UITextField *verifyCodeField;
@property (nonatomic, strong) UIView *lastSeparatorView;

@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, strong) NSTimer *downTimer;
@property (nonatomic, strong) UIButton *getVerifyCode;

@end

@implementation MerchantEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"入驻";
    self.usernameField.placeholder = @"请输入您的账号";
    self.passwordField.placeholder = @"请输入您的密码";
    [self initAndLayoutView];
}

- (void)initAndLayoutView {
    [self addTextField];
    
    [self addButton];
}

- (void)addButton {
    UIButton *enterButton = [Public loginTypeButton:@"入驻"];
    [enterButton addTarget:self action:@selector(pushToNextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];
    [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lastSeparatorView.mas_bottom).mas_equalTo(60);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"成功"]];
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

- (void)pushToUserProtocol {
    [self.navigationController pushViewController:[[UserProtocolViewController alloc] init] animated:YES];
}

- (void)pushToNextStep {
    LeagueParentViewController *leagueParentVC = [[LeagueParentViewController alloc] init];
    [self.navigationController pushViewController:leagueParentVC animated:YES];
}

- (void)startTimer {
    self.timeout = 60;
    self.getVerifyCode.enabled = NO;
    self.downTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonState) userInfo:nil repeats:YES];
}

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

- (void)addTextField {
    self.phoneNumField = [Public twoSpaceTextField:@"请输入您的手机号"];
    [self.view addSubview:self.phoneNumField];
    [self.phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //输入框分割线
    UIView *textFieldSeparator = [self separatorViewWithHeight:[DefineValue pixHeight] constraintsView:self.phoneNumField superView:self.view];
    
    self.verifyCodeField = [Public twoSpaceTextField:@"请输入您的短信验证码"];
    [self.view addSubview:self.verifyCodeField];
    [self.verifyCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textFieldSeparator.mas_bottom).offset([UIScreen mainScreen].scale);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //第二条分割线
    self.lastSeparatorView = [self separatorViewWithHeight:7 constraintsView:self.verifyCodeField superView:self.view];
    
    self.getVerifyCode = [EnterView verifyCodeButton];
    [self.getVerifyCode addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneNumField addSubview:self.getVerifyCode];
    [self.getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneNumField);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
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
