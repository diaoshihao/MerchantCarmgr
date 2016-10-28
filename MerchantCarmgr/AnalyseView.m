//
//  AnalyseView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/25.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AnalyseView.h"
#import "DefineValue.h"
#import "WeekView.h"
#import "Histogram.h"
#import "LabelView.h"
#import <Masonry.h>

typedef NS_ENUM(NSUInteger, DataType) {
    Total = 0,
    Views,
    Orders,
    Cash,
    Comment,
};

@interface AnalyseView()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *subTitles;

@end

@implementation AnalyseView

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"往日订单详情",@"近日浏览量",@"近日订单量",@"提现记录",@"往日评价量"];
    }
    return _titles;
}

- (NSArray *)subTitles {
    if (_subTitles == nil) {
        _subTitles = @[@[@"总预约量",@"总浏览量",@"总沟通量"],@[@"本日浏览量",@"本月浏览量"],@[@"本日订单量",@"本月订单量"],@[@"提现总额",@"账户余额"],@[@"1星评价",@"2星评价",@"3星评价",@"4星评价",@"5星评价"]];
    }
    return _subTitles;
}

- (instancetype)initWithData:(NSArray *)data
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setDataArr:data];
    }
    return self;
}

- (void)setDataArr:(NSArray<NSArray *> *)dataArr {
    _dataArr = dataArr;
    [self initView];
}

- (void)initView {
    UIView *lastView = nil;
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        UIView *view = [self dataViewByType:i];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == Total) {
                make.top.mas_equalTo(0);
                make.height.mas_equalTo([DefineValue screenWidth] / 2 + 44);
            } else {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            make.left.and.right.mas_equalTo(0);
            if (i == Comment) {
                make.height.mas_equalTo([DefineValue screenWidth] / 2 + 44);
                make.bottom.mas_equalTo(self.mas_bottom);
            }
        }];
        lastView = view;
    }
}

//根据类型返回view
- (UIView *)dataViewByType:(DataType)type {
    if (type == Total || type == Comment) {
        return [self dataViewWithColumnByType:type];
    } else {
        return [self dataViewNoColumnByType:type];
    }
}

//没有直方图的view
- (UIView *)dataViewNoColumnByType:(DataType)type {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [self settingLabel:self.titles[type]];
    titleLabel.backgroundColor = [DefineValue separaColor];
    titleLabel.font = [DefineValue font16];
    [back addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    WeekView *view = [[WeekView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.titles = self.subTitles[type];
    [view viewWithData:self.dataArr[type]];
    [back addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(back.mas_bottom);
    }];

    return back;
}

//有直方图的view
- (UIView *)dataViewWithColumnByType:(DataType)type {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [self settingLabel:self.titles[type]];
    titleLabel.backgroundColor = [DefineValue separaColor];
    titleLabel.font = [DefineValue font16];
    [back addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIView *dataView = nil;
    if (type == Total) {
        dataView = [self totalView];
    } else {
        dataView = [self commentView];
    }
    [back addSubview:dataView];
    [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.and.height.mas_equalTo([DefineValue screenWidth] / 2);
    }];
    
    //直方图
    NSArray *subTitles = self.subTitles[type];
    if (type == Comment) {
        subTitles = @[@"1星",@"2星",@"3星",@"4星",@"5星"];
    }
    Histogram *histogram = [[Histogram alloc] initWithItems:subTitles values:self.dataArr[type]];
    histogram.width = [DefineValue screenWidth] / 2;
    histogram.height = [DefineValue screenWidth] / 2;
    [histogram build];
    [back addSubview:histogram];
    [histogram mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(back.mas_bottom);
        make.size.mas_equalTo(CGSizeMake([DefineValue screenWidth] / 2, [DefineValue screenWidth] / 2));
    }];

    return back;
}


- (UIView *)totalView {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *labels = [NSMutableArray new];
    for (NSInteger i = 0; i < 3; i++) {
        LabelView *label = [[LabelView alloc] initWithTitle:self.subTitles[Total][i] value:self.dataArr[Total][i]];
        [back addSubview:label];
        [labels addObject:label];
    }
    
    [labels mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.width.mas_equalTo(back.mas_width);
    }];

    return back;
}

- (UIView *)commentView {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *labels = [NSMutableArray new];
    for (NSInteger i = 0; i < 3; i++) {
        LabelView *label = [[LabelView alloc] initWithTitle:self.subTitles[Comment][i] value:self.dataArr[Comment][i]];
        [back addSubview:label];
        [labels addObject:label];
    }
    
    [labels mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(back.mas_width).multipliedBy(0.5);
    }];
    
    for (NSInteger i = 3; i < 5; i++) {
        LabelView *label = [[LabelView alloc] initWithTitle:self.subTitles[Comment][i] value:self.dataArr[Comment][i]];
        [back addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            LabelView *labelView = labels.firstObject;
            make.left.mas_equalTo(labelView.mas_right);
            make.centerY.mas_equalTo(labels[i - 3]);
        }];
    }
    
    return back;
}



//设置label
- (UILabel *)settingLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = text;
    label.font = [DefineValue font14];
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
