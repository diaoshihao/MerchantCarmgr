//
//  LabelView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/25.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSString *value;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UILabel *dataLab;

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value;

@end
