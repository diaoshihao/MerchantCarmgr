//
//  Public.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "Public.h"

@implementation Public

+ (UITextField *)twoSpaceTextField:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.textColor = kFieldColor;
    textField.font = kFont14;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (UIButton *)imageButton:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeLeft;
    button.contentHorizontalAlignment = UIViewContentModeLeft;
    return button;
}

+ (UIButton *)loginTypeButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont16;
    [button setBackgroundImage:[UIImage imageNamed:@"LoginTypeBtn"] forState:UIControlStateNormal];
    return button;
}

@end
