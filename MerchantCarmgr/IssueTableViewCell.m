//
//  IssueTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 2016/12/14.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "IssueTableViewCell.h"
#import <Masonry.h>
#import "DefineValue.h"

@implementation IssueTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [DefineValue separaColor];
        [self configViews];
        [self actionView];
    }
    return self;
}

- (void)configViews {
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(68);
        make.width.mas_equalTo(self.headImageView.mas_height).multipliedBy(1.382);
    }];
    
    self.serviceName = [[UILabel alloc] init];
    self.serviceName.font = [DefineValue font15];
    [self.contentView addSubview:self.serviceName];
    
    self.state = [[UILabel alloc] init];
    self.state.font = [DefineValue font14];
    self.state.textColor = [DefineValue mainColor];
    [self.contentView addSubview:self.state];
    
    self.date = [[UILabel alloc] init];
    self.date.font = [DefineValue font12];
    self.date.textColor = [DefineValue fieldColor];
    [self.contentView addSubview:self.date];
    
    self.accessTimes = [[UILabel alloc] init];
    self.accessTimes.font = [DefineValue font14];
    self.accessTimes.textColor = [DefineValue buttonColor];
    [self.contentView addSubview:self.accessTimes];
    
    
    NSArray *views = @[self.serviceName, self.state, self.date, self.accessTimes];
    [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:10 tailSpacing:54];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
        make.right.mas_equalTo(0);
    }];
}

- (void)actionView {
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = [UIColor whiteColor];
    NSMutableArray *buttons = [NSMutableArray new];
    NSArray *titles = @[@"编辑", @"删除", @"分享"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
        button.tag = 10 + i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:button];
        [buttons addObject:button];
    }
    
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(background);
    }];
    
    [self.contentView addSubview:background];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)clickAction:(UIButton *)sender {
    self.myIssueClick(sender.tag - 10);
}

- (void)myIssueAction:(MyIssueClick)click {
    self.myIssueClick = click;
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
