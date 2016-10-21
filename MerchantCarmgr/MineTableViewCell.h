//
//  MineTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *titleLabel;

- (void)viewWithData:(NSString *)data indexPath:(NSIndexPath *)indexPath;

@end
