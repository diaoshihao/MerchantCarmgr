//
//  CommentModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *answers;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
