//
//  ColumnChart.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

/**
 * 直方图view
 */

#import <UIKit/UIKit.h>

@interface Histogram : UIView

@property (nonatomic, strong) NSArray <NSString *>*items;

@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) UIColor *tintColor; //方条颜色

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) CGFloat columnWidth; //方条宽度

@property (nonatomic, assign) CGFloat columnMargin;//方条边距

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;


- (instancetype)initWithItems:(NSArray <NSString *>*)items values:(NSArray *)values;

- (instancetype)build;//调用这个方法才有显示

@end
