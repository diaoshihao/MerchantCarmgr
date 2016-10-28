//
//  AnalyseView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/25.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalyseView : UIView

@property (nonatomic, strong) NSArray <NSArray *>*dataArr;

@property (nonatomic, strong) NSArray *total; //总量

@property (nonatomic, strong) NSArray *views; //浏览量

@property (nonatomic, strong) NSArray *orders; //订单量

@property (nonatomic, strong) NSArray *cash; //提现记录

@property (nonatomic, strong) NSArray *comments; //评论量

- (instancetype)initWithData:(NSArray *)data;

@end
