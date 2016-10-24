//
//  ComplaintTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"

@interface ComplaintTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) CustomLabel *detailLabel;

@end
