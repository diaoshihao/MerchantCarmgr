//
//  CommentModel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        self.custom_header_img = dict[@"custom_header_img"];
//        self.custom_username = dict[@"custom_username"];
//        self.advise_date = dict[@"advise_date"];
//        self.advise_star = dict[@"advise_star"];
//        self.advise_img_list = dict[@"advise_img_list"];
//        self.advise_content = dict[@"advise_content"];
//        self.answers = dict[@"answers"];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([value isEqualToString:@"null"]) {
        return;
    }
    [super setValue:value forKey:key];
}

//对未定义key处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
