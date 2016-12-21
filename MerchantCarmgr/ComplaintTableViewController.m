//
//  ComplaintTableViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ComplaintTableViewController.h"
#import "ComplaintTableViewCell.h"
#import "ComplaintModel.h"
#import "Public.h"

@interface ComplaintTableViewController ()

@end

@implementation ComplaintTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ComplaintTableViewCell class] forCellReuseIdentifier:@"complaint"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 9.99;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ComplaintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"complaint" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ComplaintModel *model = self.dataArr[indexPath.section];
    if (model.custom_header_img != nil) {
        [Public loadWebImage:model.custom_header_img didLoad:^(UIImage * _Nonnull image) {
            cell.headImageView.image = image;
        }];
    }
    cell.userName.text = model.custom_username;
    cell.timeLabel.text = model.complaint_date;
    cell.detailLabel.text = model.complaint_content;
    
    return cell;
}



@end
