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
#import <AFNetworking.h>

@interface Public : NSObject

NS_ASSUME_NONNULL_BEGIN

//异步加载图片
+ (void)loadWebImage:(NSString *)imageUrl didLoad:(void(^)(UIImage *image))block;

+ (void)saveValue:(NSString *)value key:(NSString *)key;

+ (NSString *)valueForKey:(NSString *)key;

/**
 * 创建缩进两格的TextField
 */
+ (UITextField *)twoSpaceTextField:(nullable NSString *)placeholder;

/**
 * 创建只有图片的Button
 */
+ (UIButton *)imageButton:(NSString *)imageName;

/**
 * 创建登录按钮类型的Button
 */
+ (UIButton *)loginTypeButton:(NSString *)title;

/**
 * 创建并返回alertView
 */
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message;

/**
 * 创建并返回imagePickerController
 * 参数：SourceType
 */
+ (UIImagePickerController *)imagePickerControllerWithSourType:(UIImagePickerControllerSourceType)sourceType delegate:(nullable id)delegate;

NS_ASSUME_NONNULL_END

@end
