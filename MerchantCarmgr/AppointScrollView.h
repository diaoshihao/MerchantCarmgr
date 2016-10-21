//
//  AppointScrollView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidScrollPage)(CGPoint offset);

@interface AppointScrollView : UIScrollView

@property (nonatomic, strong) NSArray *allAppointArr;

@property (nonatomic, strong) NSArray *myAppointArr;

@property (nonatomic, strong) NSArray *ongoingArr;

@property (nonatomic, strong) NSArray *completedArr;

@property (nonatomic, copy) DidScrollPage didScroll;

- (void)loadData;

@end
