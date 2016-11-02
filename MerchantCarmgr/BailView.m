//
//  BailView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BailView.h"
#import "DefineValue.h"
#import <Masonry.h>

@implementation BailView
{
    UILabel *bailLab;
}

- (instancetype)initWithBalance:(CGFloat)bail
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        self.bail = bail;
        [self initViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self initViews];
    }
    return self;
}

- (void)setBalance:(CGFloat)bail {
    _bail = bail;
    bailLab.text = [NSString stringWithFormat:@"%.2lf",bail];
}

- (void)initViews {
    UIView *bailView = [self balanceLabel];
    [self addSubview:bailView];
    [bailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];

    UIButton *recharge = [self buttonWithTitle:@"充值"];
    recharge.tag = 20;
    [self addSubview:recharge];
    [recharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bailView.mas_bottom).offset(60);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    UIButton *withDraw = [self buttonWithTitle:@"提现"];
    withDraw.tag = 21;
    [self addSubview:withDraw];
    [withDraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(recharge.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
}

- (UIView *)balanceLabel {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"您的保证金余额";
    [back addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(back);
    }];
    bailLab = [[UILabel alloc] init];
    bailLab.text = [NSString stringWithFormat:@"%.2lf",self.bail ? self.bail : 0.00];
    bailLab.textAlignment = NSTextAlignmentRight;
    [back addSubview:bailLab];
    [bailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(back);
    }];
    return back;
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClick:(UIButton *)sender {
    self.buttonClick(sender.tag - 20);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
