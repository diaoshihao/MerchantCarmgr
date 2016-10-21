//
//  IssueLabel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "IssueLabel.h"
#import "DefineValue.h"

@implementation IssueLabel

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        self.text = text;
        [self setting];
    }
    return self;
}

- (void)setting {
    self.textColor = [DefineValue fieldColor];
    self.font = [UIFont systemFontOfSize:16 weight:0.5];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
