//
//  InheritForEnterViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "InheritForEnterViewController.h"

@interface InheritForEnterViewController ()

@end

@implementation InheritForEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initViewAndLayout];
}

- (void)initViewAndLayout {
    //第一条分割线
    UIView *firstView = [self separatorViewWithHeight:7 constraintsView:self.customNavBar superView:self.view];
    
    self.usernameField = [Public twoSpaceTextField:nil];
    [self.view addSubview:self.usernameField];
    [self.usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //输入框分割线
    UIView *textFieldSeparator = [self separatorViewWithHeight:[DefineValue pixHeight] constraintsView:self.usernameField superView:self.view];
    
    self.passwordField = [Public twoSpaceTextField:nil];
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textFieldSeparator.mas_bottom).offset([UIScreen mainScreen].scale);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    //第二条分割线
    self.separatorView = [self separatorViewWithHeight:7 constraintsView:self.passwordField superView:self.view];
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
