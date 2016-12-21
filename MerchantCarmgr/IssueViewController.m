//
//  IssueViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "IssueViewController.h"
#import "RightButton.h"
#import "Interface.h"
#import "IssueLabel.h"
#import "IssueModel.h"

#import "ReleaseViewController.h"
#import "IssueTableViewController.h"
#import "UIViewController+ShowView.h"

@interface IssueViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IssueViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布管理";
    [self showPage];
}

//判断用户是否有发布
- (void)loadData {
    UIView *progressHUD = [self loading:@"加载中..."];
    [self clickDisable];
    self.allowGesture = NO;
    
    NSArray *pubedservice = [Interface mappgetpubedservice];
    [MyNetworker POST:pubedservice[InterfaceUrl] parameters:pubedservice[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self.dataArr removeAllObjects];
            
            NSArray *service_list = responseObject[@"services_list"];
            if (service_list.count == 0) {
                [self showEmptyIssue];
            } else {
                for (NSDictionary *dict in service_list) {
                    IssueModel *model = [[IssueModel alloc] initWithDict:dict];
                    [self.dataArr addObject:model];
                    NSLog(@"%@",model.img_path);
                }
                [self showIssuePage];
            }
        } else {
            [self showEmptyIssue];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        [self showEmptyIssue];
    }];
}

//根据有无发布内容显示页面
- (void)showPage {
    [self loadData];
}

//无发布页面
- (void)showEmptyIssue {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"发布管理附图"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([DefineValue screenHeight] * 0.3);
        make.centerX.mas_equalTo(self.view);
    }];
    
    IssueLabel *label = [[IssueLabel alloc] initWithText:@"您还没有发布服务，快去发布吧！"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
    }];
    
}

//有发布页面
- (void)showIssuePage {
    IssueTableViewController *issueTVC = [[IssueTableViewController alloc] init];
    issueTVC.dataArr = self.dataArr;
    [self addChildViewController:issueTVC];
    self.tableView = issueTVC.tableView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
