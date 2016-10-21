//
//  StarsView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "StarsView.h"
#import <Masonry.h>

@implementation StarsView

- (void)setScore:(CGFloat)score {
    _score = score;
    [self viewWithScore:score];
}

- (void)viewWithScore:(CGFloat)score {
    for (NSInteger i = 0; i < floorf(score); i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"整分"];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(self.lastImageView.mas_right).offset(3);
            }
            make.centerY.mas_equalTo(self);
        }];
        
        self.lastImageView = imageView;
    }
    
    // 不是整数，加一个0.5分的🌟
    if ([self isInteger:score] == NO) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"半分"];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.lastImageView == nil) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(self.lastImageView.mas_right).offset(3);
            }
            make.centerY.mas_equalTo(self);
        }];
        
        self.lastImageView = imageView;
    } else {
        return;
    }
}

//判断是否是整数的评分
- (BOOL)isInteger:(CGFloat)number {
    return number == floorf(number);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
