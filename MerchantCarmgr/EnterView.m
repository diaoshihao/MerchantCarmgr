//
//  EnterView.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "EnterView.h"

@implementation EnterView
{
    EnterView *enterView;
}

+ (UIButton *)verifyCodeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [DefineValue font14];
    [button setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 6;
    button.layer.borderColor = [DefineValue mainColor].CGColor;
    button.layer.borderWidth = 1;
    return button;
}

+ (UIButton *)leftTitleAndRightImageButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"前进黑"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"前进橙"] forState:UIControlStateSelected];
    button.titleLabel.font = [DefineValue font14];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue mainColor] forState:UIControlStateSelected];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.intrinsicContentSize.width + 10, 0, -button.titleLabel.intrinsicContentSize.width - 10)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.intrinsicContentSize.width, 0, button.imageView.intrinsicContentSize.width)];
    return button;
}

+ (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [DefineValue font14];
    label.textColor = [DefineValue buttonColor];
    return label;
}

+ (CustomTextField *)textFieldWithLabelText:(NSString *)text placeholder:(NSString *)placeholder {
    CustomTextField *textField = [[CustomTextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = placeholder;
    textField.textColor = [DefineValue fieldColor];
    textField.font = [DefineValue font14];
    
    UILabel *label = [EnterView labelWithText:text];
    label.frame = CGRectMake(0, 0, label.intrinsicContentSize.width, 44);
    textField.leftView = label;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (NSDictionary *)imageViewConstraintBy:(UIView *)constraint superView:(UIView *)superView withUploadButton:(BOOL)withOrNot {
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    UploadImageView *imageView = [[UploadImageView alloc] init];
    [superView addSubview:imageView];
    [returnInfo setObject:imageView forKey:@"imageView"];
    
    if (!withOrNot) {
        return returnInfo;
    }
    
    UIButton *upload = [Public loginTypeButton:@"上传"];
    [superView addSubview:upload];
    [upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        make.left.mas_equalTo(imageView.mas_left);
        make.right.mas_equalTo(imageView.mas_right);
        make.height.mas_equalTo(30);
    }];
    [returnInfo setObject:upload forKey:@"button"];
    
    return returnInfo;
}

+ (NSDictionary *)imageViewForUploadWithLabel:(NSString *)title constraint:(UIView *)constraint superView:(UIView *)superView withUploadButton:(BOOL)withOrNot {
    UILabel *photoSide = [EnterView labelWithText:title];
    photoSide.font = [DefineValue font12];
    [superView addSubview:photoSide];
    
    NSDictionary *info = [[NSDictionary alloc] init];
    info = [EnterView imageViewConstraintBy:photoSide superView:superView withUploadButton:withOrNot];
    
    UploadImageView *imageView = info[@"imageView"];
    [photoSide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(constraint.mas_bottom).offset(0);
        make.centerX.mas_equalTo(imageView);
        make.height.mas_equalTo(44);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(photoSide.mas_bottom).offset(0);
    }];
    return info;
}

+ (UIAlertController *)alertSheetForSelectPhotoInTarget:(UIViewController *)viewController {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *fromAlbom = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [Public alertWithTitle:@"提示" message:@"相册不可用"];
            return;
        }
        UIImagePickerController *imagePicker = [Public imagePickerControllerWithSourType:UIImagePickerControllerSourceTypePhotoLibrary delegate:viewController];
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *fromCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [Public alertWithTitle:@"提示" message:@"相机不可用"];
            return;
        }
        UIImagePickerController *imagePicker = [Public imagePickerControllerWithSourType:UIImagePickerControllerSourceTypeCamera delegate:viewController];
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:fromAlbom];
    [alertVC addAction:fromCamera];
    [alertVC addAction:cancel];
    return alertVC;
}

@end
