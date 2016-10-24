//
//  ComplaintModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ComplaintModel.h"

@implementation ComplaintModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.imageUrl = dict[@"imageUrl"];
        self.userName = dict[@"userName"];
        self.time = dict[@"time"];
        self.text = dict[@"text"];
    }
    return self;
}

@end
