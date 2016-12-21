//
//  LoginViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarController.h"
#import "FindPasswordViewController.h"
#import "Interface.h"
#import "ViewController.h"
#import "UIViewController+ShowView.h"
#import "LeagueParentViewController.h"
#import "AudittingViewController.h"


@interface LoginViewController ()

@property (nonatomic, strong) UIButton *contactBtn;
@property (nonatomic, strong) UIButton *FindPasswordBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setting];
    [self initAndLayoutView];
}

- (void)login {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.usernameField.text.length == 0 || self.passwordField.text.length == 0) {
        [self showAlertMessage:@"用户名和密码不能为空"];
        return;
    }
    
    UIView *progressHUD = [self loading:@"正在登录..."];
    self.allowGesture = NO;//禁止交互和手势
    [self clickDisable];
    
    NSArray *login = [Interface mapplogin:self.usernameField.text password:self.passwordField.text type:@"0" verf_code:@"" uuid:@""];
    [MyNetworker POST:login[InterfaceUrl] parameters:login[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        [self clickEnable];
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            //判断审核状态
            if ([responseObject[@"user_private"] isEqualToString:@"Audited"]) {
                [self showHomePage];
            } else if ([responseObject[@"user_private"] isEqualToString:@"Auditting"]) {
                [self showAudittingPage];
            } else {
                [self showLeaguePage];
            }
            //存储用户名和密码
            [[NSUserDefaults standardUserDefaults] setValue:self.usernameField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setValue:self.passwordField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"token"] forKey:@"token"];
        } else {
            [self showAlertMessage:@"用户名或密码错误"];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        self.allowGesture = YES;//打开交互和手势
        [self clickEnable];
        [self connectError];
    }];
}

//showHomePage
- (void)showHomePage {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    //remove childVC
    for (UIViewController *child in rootVC.childViewControllers) {
        [child removeFromParentViewController];
    }
    //showHomePage
    ViewController *VC = (ViewController *)rootVC;
    [UIView animateWithDuration:0.5 animations:^{
        [VC showHomePage];
    }];
}

//showLeaguePage
- (void)showLeaguePage {
    LeagueParentViewController *leagueParentVC = [[LeagueParentViewController alloc] init];
    [self.navigationController pushViewController:leagueParentVC animated:YES];
}

//showAudittingPage
- (void)showAudittingPage {
    AudittingViewController *audittingVC = [[AudittingViewController alloc] init];
    [self.navigationController pushViewController:audittingVC animated:YES];
}

//(联系我们)拨打电话
- (void)contactUs {
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:400-111-9665"]]];
    [self.view addSubview:callWebview];
}

- (void)findPassword {
    FindPasswordViewController *findVC = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];
}

///////////////////////////////////////////////////////////////////////

- (void)setting {
    self.title = @"登录";
    self.usernameField.placeholder = @"请输入账号";
    self.passwordField.placeholder = @"请输入密码";
    self.usernameField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    self.passwordField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordField.rightView = [self rightView];
}

//显示／隐藏 密码
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
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
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
