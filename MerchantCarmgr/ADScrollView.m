//
//  ADScrollView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ADScrollView.h"
#import "DefineValue.h"

@implementation ADScrollView


- (void)setAutoScroll:(BOOL)autoScroll {
    if (autoScroll == YES) {
        [self autoScrollView];
    } else {
        [self manualScrollView];
    }
}

- (void)setImages:(NSArray<NSString *> *)images {
    _images = images;
    [self setting];
}

- (void)setting {
    for (NSInteger i = 0; i < self.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([DefineValue screenWidth] * i, 0, [DefineValue screenWidth], [DefineValue screenWidth] * 2 / 5)];
        imageView.image = [UIImage imageNamed:self.images[i]];
        [self addSubview:imageView];
    }
    self.contentSize = CGSizeMake([DefineValue screenWidth] * self.images.count, 0);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)autoScrollView {
    
}

- (void)manualScrollView {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
