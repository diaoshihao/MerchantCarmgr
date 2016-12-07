//
//  CommentModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, strong) NSString *custom_header_img;
@property (nonatomic, strong) NSString *custom_username;
@property (nonatomic, strong) NSString *advise_star;
@property (nonatomic, strong) NSString *advise_date;
@property (nonatomic, strong) NSString *advise_content;
@property (nonatomic, strong) NSArray *advise_img_list;
@property (nonatomic, strong) NSArray *answers;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
