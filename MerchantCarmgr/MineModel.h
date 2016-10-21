//
//  MineModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject

@property (nonatomic, strong) NSString *headImage;//头像
@property (nonatomic, strong) NSString *name;//店铺名

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
