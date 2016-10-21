//
//  ChooseServiceModel.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseServiceModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL checked;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
