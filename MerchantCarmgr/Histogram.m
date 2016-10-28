//
//  ColumnChart.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "Histogram.h"
#import <Masonry.h>
#import "DefineValue.h"

@interface Histogram()

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, assign) CGFloat aCopy;

@end

@implementation Histogram

- (NSDictionary *)data {
    if (_items.count != _values.count) {
        _data = nil;
    } else {
        _data = [NSDictionary dictionaryWithObjects:_values forKeys:_items];
    }
    return _data;
}

- (CGSize)size {
    CGFloat width = self.data.count * (self.columnWidth + self.columnMargin) + self.columnMargin;
    return CGSizeMake(width + 30, width + 64);
}

- (instancetype)build {
    [self buildColumnChart];
    return self;
}

- (instancetype)initWithItems:(NSArray <NSString *>*)items values:(NSArray *)values
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = [DefineValue mainColor];
        self.columnMargin = 10.0;
        self.columnWidth = 20.0;
        self.font = [DefineValue font14];
        self.items = items;
        self.values = values;
    }
    return self;
}

- (void)buildColumnChart {
//    CGFloat height = self.data.count * (self.columnWidth + 2 * self.columnMargin);
    self.aCopy =  (self.height - 44) / [self maxValue:self.values];
    
    NSMutableArray *columns = [NSMutableArray new];
    for (NSString *key in self.items) {
        UIView *columnView = [self columnWithText:key value:[self.data[key] floatValue]];
        [self addSubview:columnView];
        [columns addObject:columnView];
    }
    
    [columns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [columns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.height);
    }];
}

- (UIView *)columnWithText:(NSString *)text value:(CGFloat)value {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = self.backgroundColor;
    
    UIView *column = [[UIView alloc] init];
    column.backgroundColor = self.tintColor;
    [back addSubview:column];
    
    UILabel *label = [self itemLabelText:text];
    [back addSubview:label];
    
    [column mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.columnMargin / 2);
//        make.right.mas_equalTo(-self.columnMargin / 2);
        make.width.mas_equalTo(self.columnWidth);
        make.centerX.mas_equalTo(back);
        make.bottom.mas_equalTo(label.mas_top).offset(0);
        make.height.mas_equalTo(value * self.aCopy);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(back);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(back.mas_bottom);
    }];
    return back;
}

//设置标题
- (UILabel *)itemLabelText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = self.textColor;
    label.font = self.font;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

//找出给定数据的最大值
- (CGFloat)maxValue:(NSArray *)values {
    NSArray *arr = [values sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 floatValue] > [obj2 floatValue]) {
            return NSOrderedAscending;
        }
        if ([obj1 floatValue] < [obj2 floatValue]) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return [arr.firstObject floatValue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
