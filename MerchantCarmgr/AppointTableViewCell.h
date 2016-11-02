//
//  AppointTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointModel.h"

typedef NS_ENUM(NSUInteger, AppointState) {
    MyAppoint,
    Doing,
    Done,
};

@interface AppointTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) UIButton *call;
@property (nonatomic, strong) UIButton *comment;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIImageView *photoView;

@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, assign) AppointState state;

- (void)loadDataWithModel:(AppointModel *)model;

@end
