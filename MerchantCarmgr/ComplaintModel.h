//
//  ComplaintModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintModel : NSObject

@property (nonatomic, strong) NSString *custom_header_img;
@property (nonatomic, strong) NSString *custom_username;
@property (nonatomic, strong) NSString *complaint_date;
@property (nonatomic, strong) NSString *complaint_content;
@property (nonatomic, strong) NSString *complaint_finish;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
