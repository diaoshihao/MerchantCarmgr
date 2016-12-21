//
//  IssueModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/12/14.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BasicModel.h"

@interface IssueModel : BasicModel

@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *img_path;
@property (nonatomic, strong) NSString *date_time;
@property (nonatomic, strong) NSString *service_name;
@property (nonatomic, strong) NSString *access_times;

@end
