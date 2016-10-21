//
//  WeekModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekModel : NSObject

@property (nonatomic, strong) NSString *orders;//订单
@property (nonatomic, strong) NSString *income;//收入

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
