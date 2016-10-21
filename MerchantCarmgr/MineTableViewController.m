//
//  MineTableViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MineTableViewController.h"
#import "MineTableViewCell.h"
#import "DefineValue.h"

@interface MineTableViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self settingTableView];
    
}

- (void)initData {
    self.dataArr = @[@[@"商家评分"],
                     @[@"商家等级",@"账户余额",@"保证金"],
                     @[@"企业简介",@"企业照片"],
                     @[@"系统消息",@"设置"]];
    self.imageArr = @[@[@"商家评分"],
                      @[@"商家等级",@"账户余额",@"保证金"],
                      @[@"企业简介",@"企业照片"],
                      @[@"系统消息",@"设置"]];
    
}

- (void)settingTableView {
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineCell"];
    self.tableView.backgroundColor = [DefineValue separaColor];
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
    NSArray *rows = self.dataArr[section];
    return rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [DefineValue pixHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [DefineValue separaColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell" forIndexPath:indexPath];
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.leftImageView.image = [UIImage imageNamed:self.imageArr[indexPath.section][indexPath.row]];
    cell.titleLabel.text = self.dataArr[indexPath.section][indexPath.row];
    
    if (self.dataList.count != 0) {
        if (indexPath.section == 0) {
            [cell viewWithData:self.dataList[0] indexPath:indexPath];
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            [cell viewWithData:self.dataList[1] indexPath:indexPath];
        } else {
            
        }
    }
    
    //数据加载完成后根据内容是否被遮挡设置可否滑动
    if (indexPath.row == [tableView indexPathsForVisibleRows].lastObject.row) {
        if ([self tableContentSizeOverScreen] == NO) {
            self.tableView.scrollEnabled = NO;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    self.clickCell(indexPath);
}

//判断tableview内容是否超过屏幕
- (BOOL)tableContentSizeOverScreen {
    if (self.tableView.contentSize.height >= self.tableView.bounds.size.height) {
        return YES;
    }
    return NO;
}



@end
