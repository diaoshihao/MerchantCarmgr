//
//  CommentTableViewCell.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "StarsView.h"
#import <Masonry.h>
#import "DefineValue.h"
#import "ReplyTextField.h"
#import "CustomTextView.h"

@interface CommentTableViewCell()

@property (nonatomic, strong) CustomTextView *reply;
@property (nonatomic, strong) UIImageView *lastImageView;//评论图片
@property (nonatomic, strong) UIView *lastView;//最后一个view，用于约束

@property (nonatomic, strong) MASConstraint *topConstrain;
@property (nonatomic, strong) MASConstraint *bottomConstrain;

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.image = [UIImage imageNamed:@"默认头像"];
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
        make.width.and.height.mas_equalTo(44);
    }];
    
    self.userNameLab = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameLab];
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(20);
    }];
    
    self.commentLab = [[CustomLabel alloc] init];
    self.commentLab.lineSpace = 8;
    self.commentLab.font = [DefineValue font14];
    [self.contentView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    self.timeLab = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLab];
    
    self.reply = [self createAnswerTextView];
    [self.contentView addSubview:self.reply];
    [self.reply mas_makeConstraints:^(MASConstraintMaker *make) {
        self.topConstrain = make.top.mas_equalTo(self.commentLab.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        self.bottomConstrain = make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    self.lastView = self.reply;
}

- (void)setModel:(CommentModel *)model {
    if (model.custom_header_img != nil) {
        self.headImageView.image = [UIImage imageNamed:model.custom_header_img];
    }
    self.userNameLab.text = model.custom_username;
    self.timeLab.text = model.advise_date;
    self.commentLab.text = model.advise_content;
    self.images = model.advise_img_list;
    self.score = [model.advise_star floatValue];
    self.answers = [NSMutableArray arrayWithArray:model.answers];
    [self addStarsWithScore:self.score];
    
    if (self.images == nil || self.images.count != 0) {
//        [self insertImages];
    }
    
    if (self.answers.count != 0) {
//        [self initAnswers];
    }
}

- (void)insertImages {
    [self.topConstrain uninstall];
    
    self.imageViews = [NSMutableArray new];
    for (NSInteger i = 0; i < _images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:_images[i]];
        imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.commentLab.mas_bottom).offset(15);
            make.left.mas_equalTo(20 + (50 + 10) * i);
            make.width.and.height.mas_equalTo(50);
            make.bottom.mas_equalTo(self.reply.mas_top).offset(-15);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidTap:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        self.lastImageView = imageView;
        [self.imageViews addObject:imageView];
    }
    
    [self.reply mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        self.bottomConstrain = make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self layoutIfNeeded];
}

//点击查看图片
- (void)imageDidTap:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    NSUInteger index = [self.imageViews indexOfObject:imageView];
    
    NSMutableArray *images = [NSMutableArray new];
    for (UIImageView *imageV in self.imageViews) {
        [images addObject:imageV.image];
    }
    self.broswer(images, index);
}

- (void)initAnswers {
    //delete lastView's constraint of bottom
    [self.bottomConstrain uninstall];
    
    for (NSInteger i = 0; i < _answers.count; i++) {
        UIView *answerLab = [self createAnswerLabel:_answers[i]];
        [self.contentView addSubview:answerLab];
        [answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lastView.mas_bottom).offset(5);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        if (i == _answers.count - 1) {
            [answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
                self.bottomConstrain = make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
            }];
        }
        
        self.lastView = answerLab;//最后一个view是商家回复
    }
    [self layoutIfNeeded];
}

- (void)addStarsWithScore:(CGFloat)score {
    StarsView *starsView = [[StarsView alloc] init];
    starsView.score = score;
    if (starsView.lastImageView == nil) {
        return;
    }
    [self.contentView addSubview:starsView];
    [starsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameLab.mas_bottom).offset(10);
        make.left.mas_equalTo(self.userNameLab.mas_left).offset(0);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(starsView.lastImageView.mas_right).offset(15);
        make.centerY.mas_equalTo(starsView.lastImageView);
    }];
}

//回复label
- (UIView *)createAnswerLabel:(NSString *)text {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [DefineValue separaColor];
    CustomLabel *answerLab = [[CustomLabel alloc] init];
    answerLab.backgroundColor = [DefineValue separaColor];
    answerLab.lineSpace = 8;
    answerLab.text = text;
    answerLab.font = [DefineValue font12];
    [back addSubview:answerLab];
    [answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    return back;
}

//回复输入框
- (CustomTextView *)createAnswerTextView {
    CustomTextView *textView = [[CustomTextView alloc] init];
    textView.placeholder = @"回复";
    textView.layer.cornerRadius = 3;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [DefineValue separaColor].CGColor;
    textView.returnKeyType = UIReturnKeySend;
    textView.textContainerInset = UIEdgeInsetsMake(5, 2, 5, 2);
    __weak typeof(self) weakSelf = self;
    textView.returnBlock = ^(NSString *text) {//商家回复block
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        weakSelf.reload(text);
    };
    return textView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
