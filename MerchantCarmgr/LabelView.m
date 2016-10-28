//
//  LabelView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/25.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LabelView.h"
#import <Masonry.h>

@implementation LabelView

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value
{
    self = [super init];
    if (self) {
        self.title = title;
        self.value = value;
        [self create];
    }
    return self;
}

- (void)create {
    self.label = [[UILabel alloc] init];
    self.label.text = self.title;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.dataLab = [[UILabel alloc] init];
    self.dataLab.textAlignment = NSTextAlignmentCenter;
    self.dataLab.text = self.value;
    [self addSubview:self.label];
    [self addSubview:self.dataLab];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    [self.dataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
