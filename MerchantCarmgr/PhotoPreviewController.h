//
//  PhotoPreviewController.h
//  MerchantCarmgr
//
//  Created by admin on 2016/11/15.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPreviewController : UIViewController

@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, assign) BOOL animated;

@end
