//
//  ChooseServiceModel.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ChooseServiceModel.h"

@implementation ChooseServiceModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.checked = NO;
    }
    return self;
}

@end
