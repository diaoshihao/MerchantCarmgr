//
//  DataView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataView : UIView

@property (nonatomic, strong) NSArray *data;

- (void)viewWithData:(NSArray *)data;

- (UILabel *)settingLabel:(NSString *)text;

- (void)updateWithData:(NSArray *)data;

@end
