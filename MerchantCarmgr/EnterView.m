//
//  EnterView.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "EnterView.h"

@implementation EnterView

+ (UIView *)separatorView {
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = kSeparaColor;
    return separatorView;
}

+ (UIButton *)verifyCodeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    button.titleLabel.font = kFont14;
    [button setTitleColor:kMianColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 6;
    button.layer.borderColor = kMianColor.CGColor;
    button.layer.borderWidth = 1;
    return button;
}

+ (UIButton *)leftTitleAndRightImageButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"前进黑"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"前进橙"] forState:UIControlStateSelected];
    button.titleLabel.font = kFont14;
    [button setTitleColor:kButtonColor forState:UIControlStateNormal];
    [button setTitleColor:kMianColor forState:UIControlStateSelected];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.intrinsicContentSize.width + 10, 0, -button.titleLabel.intrinsicContentSize.width - 10)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.intrinsicContentSize.width, 0, button.imageView.intrinsicContentSize.width)];
    return button;
}

+ (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = kFont14;
    label.textColor = kButtonColor;
    return label;
}

+ (UITextField *)textFieldWithLabelText:(NSString *)text placeholder:(NSString *)placeholder {
    CustomTextField *textField = [[CustomTextField alloc] init];
    textField.placeholder = placeholder;
    textField.textColor = kFieldColor;
    textField.font = kFont14;
    
    UILabel *label = [EnterView labelWithText:text];
    label.frame = CGRectMake(0, 0, label.intrinsicContentSize.width, 44);
    textField.leftView = label;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (UIImageView *)imageViewForUploadPhoto {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor lightGrayColor];
    return imageView;
}

@end
