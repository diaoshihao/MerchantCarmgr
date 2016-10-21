//
//  HeadView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "HeadView.h"
#import "DefineValue.h"
#import <Masonry.h>

@interface HeadView()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLab;

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setting];
    }
    return self;
}

- (void)setHeadImage:(UIImage *)headImage {
    _headImage = headImage;
    self.headImageView.image = headImage;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLab.text = name;
}

- (void)setting {
    self.backgroundColor = [DefineValue mainColor];
    self.userInteractionEnabled = YES;
    self.headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    self.headImageView.userInteractionEnabled = YES;
    [self addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.textColor = [UIColor whiteColor];
    self.nameLab.text = self.name;
    self.nameLab.font = [DefineValue font15];
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
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
