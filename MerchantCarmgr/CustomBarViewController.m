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
    self.backColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addLeftItemButton {
    self.leftItemButton = [Public imageButton:@"后退橙"];
    [self.leftItemButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.leftItemButton];
    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)separatorViewWithHeight:(CGFloat)height constraintsView:(UIView *)contraintsView superView:(UIView *)superView {
    UIView *separatorView = [GeneralView separatorView];
    if (height == [DefineValue pixHeight]) {
        separatorView.backgroundColor = kColor(200, 199, 204, 1);
    }
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
