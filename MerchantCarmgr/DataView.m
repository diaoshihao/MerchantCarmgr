//
//  DataView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "DataView.h"
#import "DefineValue.h"

@interface DataView()

@end

@implementation DataView

- (void)viewWithData:(NSArray *)data {
    CGFloat screenWidth = [DefineValue screenWidth];
    self.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"总浏览量",@"预约量",@"沟通量"];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *label = [self settingLabel:titles[i]];
        label.frame = CGRectMake(screenWidth / 3 * i, 5, screenWidth / 3, 30);
        UILabel *dataLab = [self settingLabel:data[i]];
        dataLab.frame = CGRectMake(screenWidth / 3 * i, 25, screenWidth / 3, 30);
        [self addSubview:label];
        [self addSubview:dataLab];
    }
}

- (UILabel *)settingLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [DefineValue font14];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)setData:(NSArray *)data {
    _data = data;
    [self updateWithData:data];
}

- (void)updateWithData:(NSArray *)data {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self viewWithData:data];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
