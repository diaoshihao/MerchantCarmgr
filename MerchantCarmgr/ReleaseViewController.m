//
//  ReleaseViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ReleaseViewController.h"
#import "GeneralControl.h"
#import "CustomTextView.h"
#import "EnterView.h"
#import "ChooseServiceViewController.h"

@interface ReleaseViewController ()

@property (nonatomic, strong) UITextField *titleTextField;

@property (nonatomic, strong) CustomTextView *detailTextField;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *pick;

@property (nonatomic, strong) UIButton *chooseService;

@property (nonatomic, strong) NSMutableArray *textFields;

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
    [self initPickPhotoButton];
    [self initChooseView];
    [self initReleaseButton];
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
    self.detailTextField = [[CustomTextView alloc] init];
    self.detailTextField.placeholder = @"服务内容";
    [self.view addSubview:self.detailTextField];
    [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTextField.mas_bottom).offset([DefineValue pixHeight] * 2);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 0.3);
    }];
}

- (void)initPickPhotoButton {
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailTextField.mas_bottom);
        make.left.and.right.mas_equalTo(0);
    }];
    
    self.pick = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pick setBackgroundImage:[UIImage imageNamed:@"选取图片"] forState:UIControlStateNormal];
    [self.pick addTarget:self action:@selector(pickPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.pick];
    [self.pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.and.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-10);
    }];
    
}

- (void)initChooseView {
    self.textFields = [NSMutableArray new];
    NSArray *titles = @[@"价格", @"服务类型", @"服务范围"];
    NSArray *placeholders = @[@"请输入价格", @"选择", @"请输入服务范围"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UITextField *textField =[EnterView textFieldWithLabelText:titles[i] placeholder:placeholders[i]];
        if (i == 1) {
            textField.placeholder = nil;
            [self chooseButtonAt:textField];
        }
        [self.view addSubview:textField];
        
        CGFloat topOffset = 10 + i * (44 + 2 * [DefineValue pixHeight]);
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backView.mas_bottom).offset(topOffset);
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        [self.textFields addObject:textField];
    }

}

- (void)chooseButtonAt:(UITextField *)textField {
    self.chooseService = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseService setTitle:@"选择" forState:UIControlStateNormal];
    [self.chooseService setTitleColor:kColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.chooseService.titleLabel.font = [DefineValue font14];
    [self.chooseService addTarget:self action:@selector(chooseServiceAction) forControlEvents:UIControlEventTouchUpInside];
    [textField addSubview:self.chooseService];
    CGFloat widthOffset = textField.leftView.intrinsicContentSize.width + 40;
    [self.chooseService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(textField.mas_left).offset(widthOffset);
        make.height.mas_equalTo(44);
    }];
}

- (void)initReleaseButton {
    UIButton *release = [GeneralControl loginTypeButton:@"发布"];
    [release addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:release];
    [release mas_makeConstraints:^(MASConstraintMaker *make) {
        UITextField *textField = self.textFields.lastObject;
        make.top.mas_equalTo(textField.mas_bottom).offset(50);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - 事件

- (void)pickPhoto {
    
}

- (void)chooseServiceAction {
    ChooseServiceViewController *chooseServiceVC = [[ChooseServiceViewController alloc] init];
    chooseServiceVC.serviceBlock = ^(NSArray *services) {
        NSString *serviceStr = [services componentsJoinedByString:@" "];
        [self.chooseService setTitle:serviceStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:chooseServiceVC animated:YES];
}

- (void)releaseAction {
    
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
