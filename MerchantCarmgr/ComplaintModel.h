//
//  ComplaintModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *text;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
