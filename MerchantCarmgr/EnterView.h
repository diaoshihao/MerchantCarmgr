//
//  EnterView.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "Public.h"
#import "CustomTextField.h"

@interface EnterView : NSObject

/**
 * 创建分割View
 */
+ (UIView *)separatorView;

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
 * 创建并返回上传图片的显示窗口imageview
 */
+ (UIImageView *)imageViewForUploadPhoto;

@end
