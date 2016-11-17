//
//  PreviewCollectionViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/11/15.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineValue.h"
#import <Masonry.h>

@interface PreviewCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) void (^singleTapGestureBlock)();

- (void)recoverSubviews;

@end
