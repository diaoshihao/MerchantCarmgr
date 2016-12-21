//
//  LevelView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LevelView.h"
#import <Masonry.h>
#import "DefineValue.h"

@interface LevelView()

@property (nonatomic, strong) UIImageView *levelImageView;

@property (nonatomic, strong) UILabel *positiveLab;

@property (nonatomic, strong) UILabel *nextLevelLab;

@end

@implementation LevelView
{
    UIImageView *backImageView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [DefineValue separaColor];
        [self initViews];
    }
    return self;
}

- (void)setGrade:(NSUInteger)grade {
    _grade = grade;
    [self.levelImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(backImageView.mas_width).multipliedBy(grade / 5.0);
    }];
    
    [self myLevelView];//先获得等级数据在创建view
}

- (void)setPositive:(NSInteger)positive {
    _positive = positive;
    self.positiveLab.text = [NSString stringWithFormat:@"好评量：%ld",self.positive];
}

- (void)setNextLevel:(NSInteger)nextLevel {
    _nextLevel = nextLevel;
    self.nextLevelLab.text = [NSString stringWithFormat:@"距离下次升级还有：%ld",self.nextLevel];
}

- (void)initViews {
    UILabel *myLevel = [self labelWithText:@"我的等级"];
    [self addSubview:myLevel];
    [myLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
    }];
    
    backImageView = [[UIImageView alloc] init];
    backImageView.backgroundColor = [UIColor whiteColor];
    backImageView.layer.cornerRadius = 7.5;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myLevel.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(15);
    }];
    self.levelImageView = [[UIImageView alloc] init];
    self.levelImageView.backgroundColor = [DefineValue mainColor];
    self.levelImageView.layer.cornerRadius = 7.5;
    [self addSubview:self.levelImageView];
    [self.levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backImageView);
        make.left.mas_equalTo(backImageView);
        make.height.mas_equalTo(backImageView);
    }];
    
    [self levelImage];
    
}

- (void)levelImage {
    NSMutableArray *imageViews = [NSMutableArray new];
    NSArray *imageNames = @[@"等级1",@"等级2",@"等级3",@"等级4",@"等级5"];
    UIImageView *lastImageView = nil;
    for (NSInteger i = 0; i < imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [self addSubview:imageView];
        [imageViews addObject:imageView];
        lastImageView = imageView;
    }
    CGFloat fixedSpacing = ([DefineValue screenWidth] - 40 - lastImageView.intrinsicContentSize.width * 4) / 4;
    [imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:fixedSpacing leadSpacing:20 tailSpacing:20];
    [imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.levelImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(lastImageView.intrinsicContentSize.height);
    }];
    
    self.positiveLab = [self labelWithText:[NSString stringWithFormat:@"好评量：%ld",self.positive]];
    [self addSubview:self.positiveLab];
    self.nextLevelLab = [self labelWithText:[NSString stringWithFormat:@"距离下次升级还有：%ld",self.nextLevel]];
    self.nextLevelLab.numberOfLines = 0;
    [self addSubview:self.nextLevelLab];
    NSArray *arr = @[self.positiveLab,self.nextLevelLab];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastImageView.mas_bottom).offset(15);
    }];
}

- (void)myLevelView {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    UILabel *label = [self labelWithText:@"我的等级"];
    [self addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.positiveLab.mas_bottom).offset(20);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [back addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(back);
        make.left.mas_equalTo(20);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"等级%lu",self.grade]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(10);
        make.centerY.mas_equalTo(back);
    }];
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
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
