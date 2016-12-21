//
//  LevelViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelView.h"
#import "Public.h"

@interface LevelViewController ()

@property (nonatomic, strong) LevelView *levelView;

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商家等级";
    [self showPage];
}

- (void)showPage {
    [self initView];
}

- (void)initView {
    self.levelView = [[LevelView alloc] init];
    self.levelView.grade = [[Public valueForKey:@"merchants_level"] integerValue];
    self.levelView.positive = 100;
    self.levelView.nextLevel = 20;
    [self.view addSubview:self.levelView];
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.and.right.mas_equalTo(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button setTitle:@"等级说明" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(levelExplanation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.levelView.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
    }];
}

- (void)levelExplanation {
    
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
