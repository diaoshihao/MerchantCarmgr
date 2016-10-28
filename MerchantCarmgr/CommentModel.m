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
        self.headImage = dict[@"headImage"];
        self.userName = dict[@"userName"];
        self.time = dict[@"time"];
        self.score = dict[@"score"];
        self.images = dict[@"images"];
        self.comment = dict[@"comment"];
        self.answers = dict[@"answers"];
    }
    return self;
}

@end
