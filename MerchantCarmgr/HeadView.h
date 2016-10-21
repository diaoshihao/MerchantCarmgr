//
//  HeadView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIImageView

@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithFrame:(CGRect)frame;

@end
