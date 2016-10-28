//
//  AppointScrollView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidScrollPage)(CGPoint offset);

@interface CustomScrollView : UIScrollView

@property (nonatomic, strong) NSArray <UIView *>*views;

@property (nonatomic, assign) CGSize singleSize;//single view's size

@property (nonatomic, copy) DidScrollPage didScroll;

- (instancetype)initWithViews:(NSArray *)views;


@end
