//
//  Public.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/12.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DefineValue.h"

@interface Public : NSObject

/**
 * 创建缩进两格的TextField
 */
+ (UITextField *)twoSpaceTextField:(NSString *)placeholder;

/**
 * 创建只有图片的Button
 */
+ (UIButton *)imageButton:(NSString *)imageName;

/**
 * 创建登录按钮类型的Button
 */
+ (UIButton *)loginTypeButton:(NSString *)title;

@end
