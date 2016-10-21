//
//  InheritForLeagueViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

/******************************************************
 给加盟页的继承类
 *****************************************************/

#import "CustomBarViewController.h"
#import "PPNetworkHelper.h"

typedef NS_ENUM(NSUInteger, EnterStep) {
    EnterStepOperator = 0,  //经营者信息
    EnterStepMerchant,      //商户信息
    EnterStepLeague,        //加盟信息
};

@interface InheritForLeagueViewController : CustomBarViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *separatorView;

@property (nonatomic, assign) EnterStep enterStep;

/**
 * 更改加盟对应的步骤颜色
 */
- (void)changeButtonColorWithStep:(EnterStep)enterStep;

/**
 * 创建并返回带有底部分割线的CustomTextField
 */
- (UITextField *)customTextFieldWithSeparator:(NSString *)labelTitle placeholder:(NSString *)placeholder superView:(UIView *)superView;

@end
