//
//  ReleaseViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ReleaseViewController.h"
#import "GeneralControl.h"
#import "ReleaseTextView.h"

@interface ReleaseViewController ()

@property (nonatomic, strong) UITextField *titleTextField;

@property (nonatomic, strong) ReleaseTextView *detailTextField;

@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布服务";
    [self showPage];
}

- (void)showPage {
    [self initTitleTextField];
    [self initDetailTextView];
}

- (void)initTitleTextField {
    self.titleTextField = [GeneralControl twoSpaceTextField:@"标题内容"];
    [self.view addSubview:self.titleTextField];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset([DefineValue pixHeight] * 2);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)initDetailTextView {
    self.detailTextField = [[ReleaseTextView alloc] init];
    self.detailTextField.placeholder = @"服务内容";
    [self.view addSubview:self.detailTextField];
    [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTextField.mas_bottom).offset([DefineValue pixHeight] * 2);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 0.3);
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
