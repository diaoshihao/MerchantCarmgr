//
//  CommentTableViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"

@interface CommentTableViewController ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation CommentTableViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"comment"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
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
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CommentModel *model = self.dataArr[indexPath.section];
    cell.model = model;
    cell.reload = ^(NSString *text) {
        [self uploadReply:text indexPath:indexPath];
    };
    cell.broswer = ^(NSArray *images, NSUInteger index) {
        [self.broswerDelegate showBroserAtIndex:index In:images];
    };
    return cell;
}

//回复内容上传
- (void)uploadReply:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    //if success
    
    //update data of model
    CommentModel *model = self.dataArr[indexPath.section];
    NSMutableArray *answers = [NSMutableArray arrayWithArray:model.answers];
    [answers addObject:text];
    model.answers = answers;
    NSLog(@"----%@",model.answers.lastObject);
    [self.dataArr replaceObjectAtIndex:indexPath.section withObject:model];
    
    //reload data of the row
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
