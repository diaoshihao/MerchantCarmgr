//
//  MerchantInfoViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MerchantInfoViewController.h"

@interface MerchantInfoViewController ()

@property (nonatomic, strong) UITextField *merchantName;
@property (nonatomic, strong) UITextField *detailAddress;
@property (nonatomic, strong) UITextField *phoneNumber;

@property (nonatomic, strong) UIButton *chooseCity;

@end

@implementation MerchantInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将当前页面对应的步骤颜色改变
    [self changeButtonColorWithStep:EnterStepMerchant];
    
    //创建View
    [self initAndLayoutView];
}

- (void)initAndLayoutView {
    self.merchantName = [self customTextFieldWithSeparator:@"店面名字" placeholder:@"提交后不可更改" superView:self.view];
    [self.merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UITextField *areaField = [self customTextFieldWithSeparator:@"店面名字" placeholder:nil superView:self.view];
    areaField.enabled = NO;
    [areaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.merchantName.mas_bottom).offset(kPixHeight);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.chooseCity = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseCity setTitle:@"选择" forState:UIControlStateNormal];
    [self.chooseCity setTitleColor:kColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.chooseCity.titleLabel.font = kFont14;
    [areaField addSubview:self.chooseCity];
    CGFloat widthOffset = areaField.leftView.intrinsicContentSize.width + 40;
    [self.chooseCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(areaField.mas_left).offset(widthOffset);
        make.height.mas_equalTo(44);
    }];
    
    self.detailAddress = [self customTextFieldWithSeparator:@"具体地址" placeholder:@"请输入地址" superView:self.view];
    [self.detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(areaField.mas_bottom).offset(kPixHeight);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.phoneNumber = [self customTextFieldWithSeparator:@"咨询/服务电话" placeholder:@"请输入电话号码" superView:self.view];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailAddress.mas_bottom).offset(kPixHeight);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label = [EnterView labelWithText:@"营业执照"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumber.mas_bottom).offset(kPixHeight);
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
    UIViewController *nextVC = self.parentViewController.childViewControllers[2];
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
