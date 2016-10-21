//
//  EnterView.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry.h>
#import "Public.h"
#import "GeneralView.h"
#import "CustomTextField.h"
#import "UploadImageView.h"

@interface EnterView : UIView


/**
 * 创建发送验证码Button
 */
+ (UIButton *)verifyCodeButton;

/**
 * 创建并返回左图右文形式的Button
 */
+ (UIButton *)leftTitleAndRightImageButton:(NSString *)title;

/**
 * 创建并返回带有label的textField
 */
+ (UITextField *)textFieldWithLabelText:(NSString *)text placeholder:(NSString *)placeholder;

/**
 * 创建并返回14号字体kButtonColor的label
 */
+ (UILabel *)labelWithText:(NSString *)text;

/**
 * 创建带有上传按钮的imageView
 * 是否带有按钮通过Bool值传递
 * 返回字典
 */
+ (NSDictionary *)imageViewConstraintBy:(UIView *)constraint superView:(UIView *)superView withUploadButton:(BOOL)withOrNot;

/**
 * 创建带有title和上传按钮的imageview
 * 返回字典
 */
+ (NSDictionary *)imageViewForUploadWithLabel:(NSString *)title constraint:(UIView *)constraint superView:(UIView *)superView withUploadButton:(BOOL)withOrNot;

/**
 * 创建并返回AlertSheet
 */
+ (UIAlertController *)alertSheetForSelectPhotoInTarget:(UIViewController *)viewController;

@end
