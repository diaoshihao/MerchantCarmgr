//
//  AnalyseModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/12/6.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AnalyseModel.h"

@implementation AnalyseModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.total_subscribe = [NSString stringWithString:dict[@"total_subscribe"]];
        self.total_access = [NSString stringWithString:dict[@"total_access"]];
        self.total_communicate = [NSString stringWithString:dict[@"total_communicate"]];
        self.day_total_subscribe = [NSString stringWithString:dict[@"day_total_subscribe"]];
        self.month_total_subscribe = [NSString stringWithString:dict[@"month_total_subscribe"]];
        self.day_total_order = [NSString stringWithString:dict[@"day_total_order"]];
        self.month_total_order = [NSString stringWithString:dict[@"month_total_order"]];
        self.fatch_cash_total = [NSString stringWithString:dict[@"fatch_cash_total"]];
        self.account_balance = [NSString stringWithString:dict[@"account_balance"]];
        self.evaluate_start_1 = [NSString stringWithString:dict[@"evaluate_start_1"]];
        self.evaluate_start_2 = [NSString stringWithString:dict[@"evaluate_start_2"]];
        self.evaluate_start_3 = [NSString stringWithString:dict[@"evaluate_start_3"]];
        self.evaluate_start_4 = [NSString stringWithString:dict[@"evaluate_start_4"]];
        self.evaluate_start_5 = [NSString stringWithString:dict[@"evaluate_start_5"]];
    }
    return self;
}

@end
