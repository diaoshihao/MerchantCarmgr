//
//  MyViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewController.h"
#import "HeadView.h"
#import "WeekView.h"

#import "LevelViewController.h"
#import "BalanceViewController.h"
#import "BailViewController.h"
#import "IntroduceViewController.h"
#import "MyPhotoViewController.h"
#import "MessageViewController.h"
#import "SettingViewController.h"

@interface MineViewController ()

@property (nonatomic, strong) HeadView *headView;

@property (nonatomic, strong) WeekView *weekView;

@property (nonatomic, strong) NSArray *viewcontrollers;

@end

@implementation MineViewController

- (NSArray *)viewcontrollers {
    if (_viewcontrollers == nil) {
        _viewcontrollers = @[@[@""],
                             @[@"LevelViewController",@"BalanceViewController",@"BailViewController"],
                             @[@"IntroduceViewController",@"MyPhotoViewController"],
                             @[@"MessageViewController",@"SettingViewController"]];
    }
    return _viewcontrollers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self showPage];
}

- (void)showPage {
    [self initHeadView];
    [self initWeekView];
    [self initMineTableView];
}

- (void)initHeadView {
    self.headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], [DefineValue screenWidth] * 0.35)];
    self.headView.headImage = [UIImage imageNamed:@"头像"];
    self.headView.name = @"店铺名称";
    [self.view addSubview:self.headView];
}

- (void)initWeekView {
    self.weekView = [[WeekView alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height + 4, [DefineValue screenWidth], 60)];
    [self.weekView viewWithData:@[@"1000",@"8888"]];
    [self.view addSubview:self.weekView];
}

- (void)initMineTableView {
    MineTableViewController *tableViewController = [[MineTableViewController alloc] init];
    tableViewController.dataList = @[@"0.1",@"1"];
    
#pragma mark 点击cell的回调实现
    tableViewController.clickCell = ^(NSIndexPath *indexPath) {
        [self pushWithIndexPath:indexPath];
    };
    
    [self addChildViewController:tableViewController];
    UITableView *tableView = tableViewController.tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weekView.mas_bottom).offset([DefineValue pixHeight] - 5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-49);
    }];
}

- (void)pushWithIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.viewcontrollers[indexPath.section][indexPath.row];
    SecondaryViewController *viewController = [[NSClassFromString(className) alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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
