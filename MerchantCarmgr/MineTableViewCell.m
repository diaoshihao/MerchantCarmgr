//
//  MineTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MineTableViewCell.h"
#import <Masonry.h>
#import "StarsView.h"

@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customCellView];
    }
    return self;
}

- (void)customCellView {
    self.leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftImageView];
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

//在特定的位置add对应的图片
- (void)viewWithData:(NSString *)data indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self addStarsWithScore:[data floatValue]];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [self addGradeIcon:[data integerValue]];
    } else {
        return;
    }
}

//添加评分的🌟
- (void)addStarsWithScore:(CGFloat)score {
    StarsView *starsView = [[StarsView alloc] init];
    starsView.score = score;
    if (starsView.lastImageView == nil) {
        return;
    }
    [self.contentView addSubview:starsView];
    [starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.right.mas_equalTo(starsView.lastImageView.mas_right);
        make.height.mas_equalTo(self.contentView);
    }];
}

//添加等级标志图片
- (void)addGradeIcon:(NSInteger)grade {
    NSArray *grades = @[@"",@"等级1",@"等级2",@"等级3",@"等级4",@"等级5"];
    UIImageView *gradeImageView = [[UIImageView alloc] init];
    gradeImageView.image = [UIImage imageNamed:grades[grade]];
    [self.contentView addSubview:gradeImageView];
    
    [gradeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentView);
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
