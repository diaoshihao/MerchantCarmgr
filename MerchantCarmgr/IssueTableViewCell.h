//
//  IssueTableViewCell.h
//  MerchantCarmgr
//
//  Created by admin on 2016/12/14.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyIssueAction) {
    MyIssueActionEdit,
    MyIssueActionDelete,
    MyIssueActionShare,
};

typedef void(^MyIssueClick)(MyIssueAction action);

@interface IssueTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *serviceName;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UILabel *accessTimes;

@property (nonatomic, copy) MyIssueClick myIssueClick;

- (void)myIssueAction:(MyIssueClick)click;

@end
