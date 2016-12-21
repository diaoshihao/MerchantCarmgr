//
//  IssueTableViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/12/14.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "IssueTableViewController.h"
#import "IssueTableViewCell.h"
#import "IssueModel.h"
#import "Public.h"

@interface IssueTableViewController ()

@end

@implementation IssueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 132;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[IssueTableViewCell class] forCellReuseIdentifier:@"IssueTableViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    IssueModel *model = self.dataArr[indexPath.row];
    [Public loadWebImage:model.img_path didLoad:^(UIImage * _Nonnull image) {
        cell.headImageView.image = image;
    }];
    cell.serviceName.text = model.service_name;
    cell.date.text = model.date_time;
    cell.state.text = model.state;
    cell.accessTimes.text = [NSString stringWithFormat:@"已被浏览%@次",model.access_times];
    
    [cell myIssueAction:^(MyIssueAction action) {
        if (action == MyIssueActionEdit) {
            [self appointCurrent:indexPath];
        } else if (action == MyIssueActionDelete) {
            [self deleteCurrent:indexPath];
        } else {
            [self shareCurrent:indexPath];
        }
    }];
    return cell;
}

- (void)deleteIssue {
    
}

//删除
- (void)deleteCurrent:(NSIndexPath *)indexPath {
    [self.dataArr removeObjectAtIndex:indexPath.section];
    [self.tableView reloadData];
    [self deleteIssue];
}

//编辑
- (void)appointCurrent:(NSIndexPath *)indexPath {
    
}

//分享
- (void)shareCurrent:(NSIndexPath *)indexPath {
    
}


@end
