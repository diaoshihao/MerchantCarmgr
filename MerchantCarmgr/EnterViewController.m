//
//  EnterViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "EnterViewController.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "LoginViewController.h"
#import "MerchantEnterViewController.h"

typedef NS_ENUM(NSUInteger, ButtonFor) {
    ForLogin,
    ForEnter,
};

@interface EnterViewController ()

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self backgroundImage];
    [self initView];
}

- (void)backgroundImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"引导页"];
    [self.view addSubview:imageView];
}

- (void)initView {
    CGFloat height = ([DefineValue screenWidth] * 40 / 75 - 100) / 2;//距离底部的高度
    UIButton *enterBtn = [self createButtonWithTitle:@"入驻易务车宝" UseFor:ForEnter];
    [enterBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterBtn];
    [enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-height);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *loginBtn = [self createButtonWithTitle:@"登录" UseFor:ForLogin];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(enterBtn);
        make.bottom.mas_equalTo(enterBtn.mas_top).offset(-15);
        make.height.mas_equalTo(enterBtn);
    }];
}

- (void)login {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)enter {
    MerchantEnterViewController *merchantEnterVC = [[MerchantEnterViewController alloc] init];
    [self.navigationController pushViewController:merchantEnterVC animated:YES];
}

- (UIButton *)createButtonWithTitle:(NSString *)title UseFor:(ButtonFor)useFor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 6;
    button.titleLabel.font = [DefineValue font16];
    switch (useFor) {
        case ForLogin:
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
            break;
        case ForEnter:
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            break;
            
        default:
            break;
    }
    return button;
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
