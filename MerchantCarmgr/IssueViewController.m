//
//  IssueViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "IssueViewController.h"
#import "IssueLabel.h"
#import "RightButton.h"

#import "ReleaseViewController.h"

@interface IssueViewController ()

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseSetting];
    [self showPage];
}

- (void)baseSetting {
    self.title = @"发布管理";
    self.barTitleLabel.textColor = [UIColor whiteColor];
    [self rightButtonItem];
}

- (void)rightButtonItem {
    self.rightItemButton = [[RightButton alloc] initWithTitle:@"我要发布"];
    [self.rightItemButton addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];
}

- (void)pushViewController {
    ReleaseViewController *releaseVC = [[ReleaseViewController alloc] init];
    releaseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:releaseVC animated:YES];
}

//判断用户是否有发布
- (BOOL)userHasIssue {
    return NO;
}

//根据有无发布内容显示页面
- (void)showPage {
    if ([self userHasIssue]) {
        [self showIssuePage];
    } else {
        [self showEmptyIssue];
    }
}

//无发布页面
- (void)showEmptyIssue {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"发布管理附图"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([DefineValue screenHeight] * 0.3);
        make.centerX.mas_equalTo(self.view);
    }];
    
    IssueLabel *label = [[IssueLabel alloc] initWithText:@"您还没有发布服务，快去发布吧！"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
    }];
    
}

//有发布页面
- (void)showIssuePage {
    
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
