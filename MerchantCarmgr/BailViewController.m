//
//  BailViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BailViewController.h"
#import "BailView.h"
#import "Public.h"

@interface BailViewController ()

@property (nonatomic, strong) BailView *bailView;

@end

@implementation BailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"保证金";
    [self showPage];
}

- (void)showPage {
    [self initView];
}

- (void)initView {
    self.bailView = [[BailView alloc] init];
    self.bailView.bail = [[Public valueForKey:@"deposit"] floatValue];
    __weak typeof(self) weakSelf = self;
    self.bailView.buttonClick = ^(Bail bail) {
        [weakSelf pushToPage:bail];
    };
    [self.view addSubview:self.bailView];
    [self.bailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"什么是保证金" forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bailView.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
    }];
}

- (void)pushToPage:(Bail)bail {
    
}

- (void)buttonAction {
    
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
