//
//  RightButton.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "RightButton.h"
#import "DefineValue.h"

@implementation RightButton

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setting];
    }
    return self;
}

- (void)setting {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.titleLabel.font = [DefineValue font15];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
