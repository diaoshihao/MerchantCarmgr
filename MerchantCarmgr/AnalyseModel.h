//
//  AnalyseModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/12/6.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyseModel : NSObject

@property (nonatomic, strong) NSString *total_subscribe;
@property (nonatomic, strong) NSString *total_access;
@property (nonatomic, strong) NSString *total_communicate;
@property (nonatomic, strong) NSString *day_total_subscribe;
@property (nonatomic, strong) NSString *month_total_subscribe;
@property (nonatomic, strong) NSString *day_total_order;
@property (nonatomic, strong) NSString *month_total_order;
@property (nonatomic, strong) NSString *fatch_cash_total;
@property (nonatomic, strong) NSString *account_balance;
@property (nonatomic, strong) NSString *evaluate_start_1;
@property (nonatomic, strong) NSString *evaluate_start_2;
@property (nonatomic, strong) NSString *evaluate_start_3;
@property (nonatomic, strong) NSString *evaluate_start_4;
@property (nonatomic, strong) NSString *evaluate_start_5;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
