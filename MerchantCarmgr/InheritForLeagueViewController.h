//
//  InheritForLeagueViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomBarViewController.h"

typedef NS_ENUM(NSUInteger, EnterStep) {
    EnterStepOperator = 0,
    EnterStepMerchant,
    EnterStepLeague,
};

@interface InheritForLeagueViewController : CustomBarViewController

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
