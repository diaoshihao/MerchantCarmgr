//
//  PhotoManager.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "PhotoManager.h"

@implementation PhotoManager

+ (PhotoManager *)shareManager {
    static PhotoManager *shareManager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareManager = [[PhotoManager alloc] init];
    });
    return shareManager;
}

@end
