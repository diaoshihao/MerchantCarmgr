//
//  AppointScrollView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomScrollView.h"
#import "DefineValue.h"
#import <Masonry.h>

@interface CustomScrollView() <UIScrollViewDelegate>

@end

@implementation CustomScrollView

- (instancetype)initWithViews:(NSArray *)views
{
    self = [super init];
    if (self) {
        [self setting];
        self.views = views;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setting];
    }
    return self;
}

- (void)setSingleSize:(CGSize)singleSize {
    _singleSize = singleSize;
    if (_views != nil) {
        [self createViews];
    }
}

- (void)setting {
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)createViews {
    for (NSInteger i = 0; i < self.views.count; i++) {
        UIView *view = self.views[i];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(self.singleSize.width * i);
            make.width.mas_equalTo(self.singleSize.width);
            make.height.mas_equalTo(self.singleSize.height);
        }];
    }
    self.contentSize = CGSizeMake(self.singleSize.width * self.views.count, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.didScroll(scrollView.contentOffset);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
