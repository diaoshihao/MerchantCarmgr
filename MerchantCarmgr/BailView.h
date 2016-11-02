//
//  BailView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Bail) {
    Recharge,//充值
    WithdrawMoney,//提现
};

typedef void(^ButtonClick)(Bail);

@interface BailView : UIView

@property (nonatomic, assign) CGFloat bail;

@property (nonatomic, copy) ButtonClick buttonClick;

- (instancetype)initWithBalance:(CGFloat)bail;

@end
