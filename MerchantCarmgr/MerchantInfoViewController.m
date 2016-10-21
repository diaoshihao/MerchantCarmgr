//
//  MerchantInfoViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MerchantInfoViewController.h"
#import "AddressPickerController.h"

@interface MerchantInfoViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *merchantName;
@property (nonatomic, strong) UITextField *detailAddress;
@property (nonatomic, strong) UITextField *phoneNumber;

@property (nonatomic, strong) UIButton *chooseCity;

@property (nonatomic, strong) UploadImageView *imageView;

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
    
    UITextField *areaField = [self customTextFieldWithSeparator:@"所在地区" placeholder:nil superView:self.view];
    areaField.delegate = self;
    [areaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.merchantName.mas_bottom).offset([DefineValue pixHeight]);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.chooseCity = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseCity setTitle:@"选择" forState:UIControlStateNormal];
    [self.chooseCity setTitleColor:kColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.chooseCity.titleLabel.font = [DefineValue font14];
    [self.chooseCity addTarget:self action:@selector(chooseAreaAction) forControlEvents:UIControlEventTouchUpInside];
    [areaField addSubview:self.chooseCity];
    CGFloat widthOffset = areaField.leftView.intrinsicContentSize.width + 40;
    [self.chooseCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(areaField.mas_left).offset(widthOffset);
        make.height.mas_equalTo(44);
    }];
    
    self.detailAddress = [self customTextFieldWithSeparator:@"具体地址" placeholder:@"请输入地址" superView:self.view];
    [self.detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(areaField.mas_bottom).offset([DefineValue pixHeight]);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.phoneNumber = [self customTextFieldWithSeparator:@"咨询/服务电话" placeholder:@"请输入电话号码" superView:self.view];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailAddress.mas_bottom).offset([DefineValue pixHeight]);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label = [EnterView labelWithText:@"营业执照"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumber.mas_bottom).offset([DefineValue pixHeight]);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    NSDictionary *info = [EnterView imageViewConstraintBy:nil superView:self.view withUploadButton:YES];
    self.imageView = info[@"imageView"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo([DefineValue screenWidth] / 3);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(175.0 / 250.0);
    }];
    
    UIButton *upload = info[@"button"];
    [upload addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextStep = [Public loginTypeButton:@"下一步"];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
    [nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upload.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)upload:(UIButton *)sender {
    UIAlertController *alertVC = [EnterView alertSheetForSelectPhotoInTarget:self];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)chooseAreaAction {
    AddressPickerController *addressPicker = [[AddressPickerController alloc] init];
    addressPicker.block = ^(NSArray *address) {
        NSString *area = [NSString stringWithFormat:@"%@ %@",address[0],address[1]];
        [self.chooseCity setTitle:area forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:addressPicker animated:YES];
}

- (void)nextStep {
    UIViewController *nextVC = self.parentViewController.childViewControllers[2];
    [self.parentViewController transitionFromViewController:self toViewController:nextVC duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
    [self.parentViewController.view insertSubview:nextVC.view atIndex:0];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.imageView.image = image;
        self.imageView.deleteBtn.hidden = NO;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
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
