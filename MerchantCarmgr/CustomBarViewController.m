//
//  CustomBarViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomBarViewController.h"

@interface CustomBarViewController ()

@end

@implementation CustomBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavigationBar];
}

- (void)customNavigationBar {
    UIView *stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [self.view addSubview:stateView];
    self.customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    [self.view addSubview:self.customNavBar];
    
    UIButton *leftButton = [Public imageButton:@"后退橙"];
    [leftButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    
    self.barTitleLabel = [[UILabel alloc] init];
    [self.customNavBar addSubview:self.barTitleLabel];
    [self.barTitleLabel contentHuggingPriorityForAxis:UILayoutConstraintAxisVertical];
    [self.barTitleLabel contentHuggingPriorityForAxis:UILayoutConstraintAxisHorizontal];
    [self.barTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.customNavBar);
    }];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)separatorViewWithHeight:(CGFloat)height constraintsView:(UIView *)contraintsView superView:(UIView *)superView {
    UIView *separatorView = [EnterView separatorView];
    [superView addSubview:separatorView];
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (contraintsView != nil) {
            make.top.mas_equalTo(contraintsView.mas_bottom).offset(0);
        }
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
    }];
    return separatorView;
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
