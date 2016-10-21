//
//  ClickView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickAt)(NSInteger tag);

@interface ClickView : UIView

@property (nonatomic, copy) ClickAt clickAt;

- (void)viewWithTitles:(NSArray *)titles images:(NSArray *)images;

- (void)didClickAt:(ClickAt)click;

@end
