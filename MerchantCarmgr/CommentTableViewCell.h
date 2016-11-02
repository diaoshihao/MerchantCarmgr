//
//  CommentTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import "CommentModel.h"

typedef void(^ReloadData)(NSString *text);
typedef void(^PhotoBroswer)(NSArray *images, NSUInteger index);

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) CustomLabel *commentLab;

@property (nonatomic, assign) CGFloat score;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *answers;

@property (nonatomic, strong) CommentModel *model;

@property (nonatomic, copy) ReloadData reload;
@property (nonatomic, copy) PhotoBroswer broswer;

@end
