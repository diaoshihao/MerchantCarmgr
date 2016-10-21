//
//  DefineValue.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct Screen {
    CGFloat width;
    CGFloat height;
};

@interface DefineValue : NSObject

@property (nonatomic, assign) struct Screen screen;

//Color
#define kColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kMainColor      kColor(255, 167, 0, 1)
#define kSeparaColor    kColor(240, 240, 240, 1)
#define kButtonColor    kColor(140, 140, 140, 1)
#define kFieldColor     kColor(166, 166, 166, 1)

//FontSize
#define kFont(size)     [UIFont systemFontOfSize:size]
#define kFont12         [UIFont systemFontOfSize:12]
#define kFont14         [UIFont systemFontOfSize:14]
#define kFont16         [UIFont systemFontOfSize:16]

//屏幕宽度
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

//一个像素高度pixHeight

#define kPixHeight      1/[UIScreen mainScreen].scale

//选择城市
#define kButtonWidth  (kScreenWidth - 100) / 3
#define kButtonHeight kButtonWidth * 9 / 20

+ (UIColor *)mainColor;
+ (UIColor *)separaColor;
+ (UIColor *)buttonColor;
+ (UIColor *)fieldColor;

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGFloat)pixHeight;

+ (UIFont *)font12;
+ (UIFont *)font14;
+ (UIFont *)font15;
+ (UIFont *)font16;

@end
