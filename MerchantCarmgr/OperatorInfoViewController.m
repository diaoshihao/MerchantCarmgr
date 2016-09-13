//
//  OperatorViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "OperatorInfoViewController.h"

@interface OperatorInfoViewController ()

@property (nonatomic, strong) UITextField *operatorName;
@property (nonatomic, strong) UITextField *identifierNum;

@end

@implementation OperatorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将当前页面对应的步骤颜色改变
    [self changeButtonColorWithStep:EnterStepOperator];
    
    //创建View
    [self initAndLayoutView];
}

- (void)initAndLayoutView {
    self.operatorName = [self customTextFieldWithSeparator:@"经营者名字" placeholder:@"请谨慎填写" superView:self.view];
    [self.operatorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.identifierNum = [self customTextFieldWithSeparator:@"身份证号" placeholder:@"请谨慎填写" superView:self.view];
    [self.identifierNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.operatorName.mas_bottom).offset(kPixHeight);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label = [EnterView labelWithText:@"身份证照片"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.identifierNum.mas_bottom).offset(kPixHeight);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *nextStep = [Public loginTypeButton:@"下一步"];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
    [nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-80);
        make.height.mas_equalTo(44);
    }];
}

- (void)nextStep {
    UIViewController *nextVC = self.parentViewController.childViewControllers[1];
    [self.parentViewController transitionFromViewController:self toViewController:nextVC duration:0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:nil];
    [self.parentViewController.view insertSubview:nextVC.view atIndex:0];
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
