//
//  ClickView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ClickView.h"
#import "GeneralControl.h"
#import "DefineValue.h"

@implementation ClickView

- (void)viewWithTitles:(NSArray *)titles images:(NSArray *)images {
    CGFloat length = [DefineValue screenWidth] / 2;
    CGFloat height = length / 1.5;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [GeneralControl buttonWithUpperImage:images[i] lowerTitle:titles[i]];
        button.frame = CGRectMake(length * (i % 2), height * (i / 2), length, height);
        button.tag = i + 100;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)didClickAt:(ClickAt)click {
    self.clickAt = click;
}

- (void)clickAction:(UIButton *)sender {
    self.clickAt(sender.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
