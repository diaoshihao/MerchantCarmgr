//
//  WeekView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "WeekView.h"
#import "DefineValue.h"

@implementation WeekView

- (void)viewWithData:(NSArray *)data {
    CGFloat screenWidth = [DefineValue screenWidth];
    CGFloat width = screenWidth / 2 - [DefineValue pixHeight];
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *label = [self settingLabel:self.titles[i]];
        label.frame = CGRectMake((width + 2 * [DefineValue pixHeight]) * i, 0, width, 30);
        UILabel *dataLab = [self settingLabel:data[i]];
        dataLab.frame = CGRectMake((width + 2 * [DefineValue pixHeight]) * i, 25, width, 30);
        [self addSubview:label];
        [self addSubview:dataLab];
    }
}

- (UILabel *)settingLabel:(NSString *)text {
    UILabel *label = [super settingLabel:text];
    label.backgroundColor = [UIColor whiteColor];
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
