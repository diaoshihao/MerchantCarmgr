//
//  AppointScrollView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

//=========================================
/**
 * 先设置views再设置size
 * size设置后才会加载views到scrollview上
 */
//=========================================

#import <UIKit/UIKit.h>


@interface CustomScrollView : UIScrollView

@property (nonatomic, strong) NSArray <UIView *>*views;

@property (nonatomic, assign) CGSize singleSize;//single view's size

- (instancetype)initWithViews:(NSArray *)views;


@end
