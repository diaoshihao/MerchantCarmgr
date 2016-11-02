//
//  AppointModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AppointModel.h"

@implementation AppointModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.state = dict[@"state"];
        self.order = dict[@"order"];
        self.headImage = dict[@"headImage"];
        self.name = dict[@"name"];
        self.call = dict[@"call"];
        self.photoView = dict[@"photoView"];
        self.title = dict[@"title"];
        self.time = dict[@"time"];
        self.count = dict[@"count"];
        self.cost = dict[@"cost"];
    }
    return self;
}

@end
