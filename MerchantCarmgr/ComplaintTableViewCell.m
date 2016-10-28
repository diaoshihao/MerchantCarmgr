//
//  ComplaintTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ComplaintTableViewCell.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation ComplaintTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"默认头像"]];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
        make.width.and.height.mas_equalTo(44);
    }];
    
    self.userName = [[UILabel alloc] init];
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.headImageView);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_right).offset(10);
        make.centerY.mas_equalTo(self.headImageView);
    }];
    
    self.detailLabel = [[CustomLabel alloc] init];
    self.detailLabel.lineSpace = 8;
    self.detailLabel.font = [DefineValue font14];
    
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-10);
    }];
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
