//
//  PhotoBroswerController.h
//  MerchantCarmgr
//
//  Created by admin on 2016/11/1.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBroswerController : UIViewController

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithImages:(NSArray *)images index:(NSUInteger)index;

@end
