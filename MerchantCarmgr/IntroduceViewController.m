//
//  IntroduceViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "IntroduceViewController.h"
#import "ReleaseTextView.h"
#import "GeneralControl.h"

@interface IntroduceViewController ()

@property (nonatomic, strong) ReleaseTextView *textView;

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"企业简介";
    [self showPage];
}

- (void)showPage {
    [self initTextView];
    [self buttons];
}

- (void)initTextView {
    self.textView = [[ReleaseTextView alloc] init];
    self.textView.placeholder = @"企业简介";
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(69);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 0.7);
    }];
}

- (void)buttons {
    UIButton *sureBtn = [GeneralControl loginTypeButton:@"确认"];
    [sureBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    UIButton *previewBtn = [GeneralControl loginTypeButton:@"预览"];
    [previewBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previewBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    [previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sureBtn.mas_bottom).offset(20);
        make.left.and.right.mas_equalTo(sureBtn);
        make.height.mas_equalTo(44);
    }];
}

- (void)action:(UIButton *)sender {
    
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
