//
//  MineModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.headImage = dict[@"headImage"];
        self.name = dict[@"name"];
    }
    return self;
}

@end
