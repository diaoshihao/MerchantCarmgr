//
//  ChooseServiceViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomBarViewController.h"

typedef void(^ReturnService)(NSArray *services);

@interface ChooseServiceViewController : CustomBarViewController

@property (nonatomic, copy)  ReturnService serviceBlock;

@end
