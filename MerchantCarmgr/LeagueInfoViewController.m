//
//  LeagueInfoViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LeagueInfoViewController.h"
#import "ChooseServiceViewController.h"

@interface LeagueInfoViewController () <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton *chooseService;
@property (nonatomic, strong) UIButton *uploadBtn;
@property (nonatomic, strong) UITextView *introduceField;

@property (nonatomic, strong) NSMutableArray <UploadImageView *>*imageViews;

@property (nonatomic, strong) UploadImageView *currentImageView;

@end

@implementation LeagueInfoViewController

- (NSMutableArray<UploadImageView *> *)imageViews {
    if (_imageViews == nil) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将当前页面对应的步骤颜色改变
    [self changeButtonColorWithStep:EnterStepLeague];
    
    //创建View
    [self initAndLayoutView];
}

- (void)initAndLayoutView {
    UITextField *serviceField = [self customTextFieldWithSeparator:@"店面服务内容" placeholder:nil superView:self.view];
    serviceField.tag = 100;
    serviceField.delegate = self;
    [serviceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.separatorView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    self.chooseService = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseService setTitle:@"选择" forState:UIControlStateNormal];
    [self.chooseService setTitleColor:kColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.chooseService.titleLabel.font = [DefineValue font14];
    [self.chooseService addTarget:self action:@selector(chooseServiceAction) forControlEvents:UIControlEventTouchUpInside];
    [serviceField addSubview:self.chooseService];
    CGFloat widthOffset = serviceField.leftView.intrinsicContentSize.width + 40;
    [self.chooseService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(serviceField.mas_left).offset(widthOffset);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *introduce = [EnterView labelWithText:@"店面简介"];
    [self.view addSubview:introduce];
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serviceField.mas_bottom).offset([DefineValue pixHeight]);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    self.introduceField = [self textViewWithPlaceholder:@"填写后可在商家中心修改"];
    [self.view addSubview:self.introduceField];
    [self.introduceField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduce.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(88);
    }];
    
    UIView *seperatorView = [self separatorViewWithHeight:[DefineValue pixHeight] constraintsView:self.introduceField superView:self.view];
    
    UILabel *merchantPhoto = [EnterView labelWithText:@"店面图片"];
    [self.view addSubview:merchantPhoto];
    [merchantPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(seperatorView.mas_bottom).offset([DefineValue pixHeight]);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    [self setImageviewsBy:merchantPhoto];
    self.currentImageView = self.imageViews.firstObject;
    
    self.uploadBtn = [Public loginTypeButton:@"上传"];
    [self.uploadBtn addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadBtn];
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViews.firstObject.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo([DefineValue screenWidth] / 3);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *nextStep = [Public loginTypeButton:@"下一步"];
    [nextStep addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
    [nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.uploadBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)setImageviewsBy:(UIView *)constraint {
    for (NSInteger i = 0; i < 3; i++) {
        UploadImageView *imageView = [[UploadImageView alloc] init];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(constraint.mas_bottom).offset(0);
            if (i == 0) {
                make.left.mas_equalTo([DefineValue screenWidth] * 25 / 745);
            } else if (i == 1) {
                make.centerX.mas_equalTo(self.view);
            } else {
                make.right.mas_equalTo(-[DefineValue screenWidth] * 25 / 745);
            }
            make.width.mas_equalTo([DefineValue screenWidth] * 215 / 745);
            make.height.mas_equalTo(imageView.mas_width).multipliedBy(150.0 / 215.0);
        }];
        [self.imageViews addObject:imageView];
    }
}

- (UITextView *)textViewWithPlaceholder:(NSString *)placeholder {
    UITextView *textView = [[UITextView alloc] init];
    textView.textColor = [DefineValue fieldColor];
    textView.text = @"填写后可在商家中心修改";
    textView.font = [DefineValue font12];
    textView.delegate = self;
    textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
    return textView;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.textColor = kColor(102, 102, 102, 1);
    if ([textView.text isEqualToString:@"填写后可在商家中心修改"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.textColor = [DefineValue fieldColor];
        textView.text = @"填写后可在商家中心修改";
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

- (void)upload:(UIButton *)sender {
    if ([self checkForCurrentIndex] > 2) {
        return;
    }
    UIAlertController *alertVC = [EnterView alertSheetForSelectPhotoInTarget:self];
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (NSUInteger)checkForCurrentIndex {
    for (UploadImageView *imageView in self.imageViews) {
        if (imageView.image == nil) {
            self.currentImageView = imageView;
            return [self.imageViews indexOfObject:imageView];
        }
    }
    return 3;
}

- (void)chooseServiceAction {
    ChooseServiceViewController *chooseServiceVC = [[ChooseServiceViewController alloc] init];
    chooseServiceVC.serviceBlock = ^(NSArray *services) {
        NSString *serviceStr = [services componentsJoinedByString:@" "];
        [self.chooseService setTitle:serviceStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:chooseServiceVC animated:YES];
}

- (void)nextStep {
    UIViewController *nextVC = self.parentViewController.childViewControllers[0];
    [self.parentViewController transitionFromViewController:self toViewController:nextVC duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:nil];
    [self.parentViewController.view insertSubview:nextVC.view atIndex:0];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        self.currentImageView.image = image;
        self.currentImageView.deleteBtn.hidden = NO;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
