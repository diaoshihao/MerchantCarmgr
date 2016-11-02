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

//typedef void(^DidTapView)(NSUInteger index);

//@protocol CustomScrollViewDelegate <NSObject>
//
//- (NSUInteger)tapViewAtIndex:(NSUInteger)index;
//
//@end

@interface CustomScrollView : UIScrollView

@property (nonatomic, strong) NSArray <UIView *>*views;

@property (nonatomic, assign) CGSize singleSize;//single view's size

//@property (nonatomic, copy) DidTapView didTap;//点击block

@property (nonatomic, assign) BOOL tapAllow;//是否允许点击

//@property (nonatomic, weak) id <CustomScrollViewDelegate> customDelegate;

- (instancetype)initWithViews:(NSArray *)views;


@end
