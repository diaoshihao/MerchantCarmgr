//
//  CustomBarViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BasicViewController.h"
#import "EnterView.h"

@interface CustomBarViewController : BasicViewController


/**
 * 设置分割线 参数：高度 约束View 父View
 * 可能需要更新top约束以确定位置
 */
- (UIView *)separatorViewWithHeight:(CGFloat)height constraintsView:(UIView *)contraintsView superView:(UIView *)superView;

@end
