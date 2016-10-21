//
//  WeekModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "WeekModel.h"

@implementation WeekModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.orders = dict[@"orders"];
        self.income = dict[@"income"];
    }
    return self;
}

@end
