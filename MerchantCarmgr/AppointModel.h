//
//  AppointModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/31.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointModel : NSObject

@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *call;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *photoView;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
