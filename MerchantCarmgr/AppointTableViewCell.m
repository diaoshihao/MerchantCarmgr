//
//  AppointTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AppointTableViewCell.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "Public.h"

@implementation AppointTableViewCell
{
    NSArray *stateArr;
}

- (void)loadDataWithModel:(AppointModel *)model {
//    self.state = [stateArr indexOfObject:model.subscribe_state];
    self.state = [model.subscribe_state integerValue];
    [self viewWithAppointState:self.state];
    
    self.stateLabel.text = stateArr[self.state];
    self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",model.subscribe_order];
    self.nameLabel.text = model.subscribe_service_name;
    self.titleLabel.text = model.subscribe_service_name;
    self.timeLabel.text = model.subscribe_date;
    self.countLabel.text = [NSString stringWithFormat:@"共%@件商品",model.subscribe_service_total];
    self.costLabel.text = [NSString stringWithFormat:@"¥ %@",model.subscribe_price];
    self.phoneNum = model.subscribe_user_mobile;
    if (model.subscribe_service_img.length != 0) {
        [Public loadWebImage:model.subscribe_service_img didLoad:^(UIImage * _Nonnull image) {
            self.photoView.image = image;
        }];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        stateArr = @[@"我的预约", @"进行中", @"已完成"];
        [self initView];
    }
    return self;
}

- (void)initView {
    self.stateLabel = [self label];
    [self.contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
    }];
    
    self.orderLabel = [self label];
    [self.contentView addSubview:self.orderLabel];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-20);
    }];
    
    self.headImage = [[UIImageView alloc] init];
    self.headImage.image = [UIImage imageNamed:@"默认头像"];
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stateLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(20);
        make.width.and.height.mas_equalTo(30);
    }];
    
    self.nameLabel = [self label];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(10);
        make.centerY.mas_equalTo(self.headImage);
    }];
    
    self.call = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.call setTitle:@"电话" forState:UIControlStateNormal];
    [self.contentView addSubview:self.call];
    [self.call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.headImage);
        make.height.mas_equalTo(self.headImage.mas_height);
    }];
    
    self.comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.comment setTitle:@"评价" forState:UIControlStateNormal];
    [self.contentView addSubview:self.comment];
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.call.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.headImage);
        make.height.mas_equalTo(self.headImage.mas_height);
    }];
    
    UIView *serviceView = [self serviceView];
    [self.contentView addSubview:serviceView];
    [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImage.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(serviceView.mas_width).multipliedBy(0.2);
    }];
    
    self.countLabel = [self label];
    [self.contentView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serviceView.mas_bottom);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    self.costLabel = [self label];
    self.costLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.costLabel];
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serviceView.mas_bottom);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
}

- (UIView *)serviceView {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [DefineValue separaColor];
    self.photoView = [[UIImageView alloc] init];
    self.photoView.image = [UIImage imageNamed:@"发布管理附图"];
    [back addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(self.photoView.mas_height).multipliedBy(3 / 2.0);
    }];
    self.titleLabel = [self label];
    [back addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView.mas_top).offset(8);
        make.left.mas_equalTo(self.photoView.mas_right).offset(15);
    }];
    self.timeLabel = [self label];
    [back addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoView.mas_right).offset(15);
        make.bottom.mas_equalTo(self.photoView.mas_bottom).offset(-5);
    }];
    
    return back;
}

- (void)viewWithAppointState:(AppointState)state {
    if (state == Done) {
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    } else {
        UIView *buttonsView = [self buttonsWithState:state];
        [self.contentView addSubview:buttonsView];
        [buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.countLabel.mas_bottom);
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
}

- (UIView *)buttonsWithState:(AppointState)state {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [DefineValue separaColor];
    if (state == MyAppoint) {
        NSMutableArray *buttons = [NSMutableArray new];
        NSArray *arr = @[@"拒绝",@"编辑",@"接受"];
        for (NSInteger i = 0; i < arr.count; i++) {
            UIButton *button = [self buttonWithTitle:arr[i]];
            [back addSubview:button];
            [buttons addObject:button];
        }
        [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo([DefineValue pixHeight] * 2);
            make.bottom.mas_equalTo(back.mas_bottom);
        }];
    } else if (state == Doing) {
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = [UIColor whiteColor];
        [back addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo([DefineValue pixHeight] * 2);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo([DefineValue screenWidth] * 2 / 3);
            make.bottom.mas_equalTo(back.mas_bottom);
        }];
        UIButton *button = [self buttonWithTitle:@"完成"];
        [back addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo([DefineValue pixHeight] * 2);
            make.left.mas_equalTo(whiteView.mas_right);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(back.mas_bottom);
        }];
    }
    return back;
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    return button;
}

- (UILabel *)label {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [DefineValue buttonColor];
    return label;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
