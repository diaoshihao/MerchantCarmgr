//
//  LoginViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPasswordViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIButton *contactBtn;
@property (nonatomic, strong) UIButton *FindPasswordBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.usernameField.placeholder = @"请输入账号";
    self.passwordField.placeholder = @"请输入密码";
    [self initAndLayoutView];
}

- (UIButton *)createButton:(NSString *)title selector:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)initAndLayoutView {
    self.contactBtn = [self createButton:@"联系我们" selector:@selector(contactUs)];
    [self.view addSubview:self.contactBtn];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).offset(0);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *loginButton = [Public loginTypeButton:@"登录"];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contactBtn.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    self.FindPasswordBtn = [self createButton:@"找回密码" selector:@selector(findPassword)];
    [self.view addSubview:self.FindPasswordBtn];
    [self.FindPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contactBtn.mas_top);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(self.contactBtn.mas_height);
    }];
    
}

//拨打电话
- (void)callUs {
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:400-111-9665"]]];
    [self.view addSubview:callWebview];
}

- (void)contactUs {
    [self callUs];
}

- (void)findPassword {
    FindPasswordViewController *findVC = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];
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
