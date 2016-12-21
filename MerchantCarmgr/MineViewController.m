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

#import "Interface.h"
#import "MineModel.h"

#import "Public.h"

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

@property (nonatomic, strong) MineModel *mineModel;

@property (nonatomic, strong) MineTableViewController *TVC;

@property (nonatomic, strong) NSArray *dataList;//商家评分和等级

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
    
    [self loadData];
}

//加载页面
- (void)showPage {
    [self initHeadView];
    [self initWeekView];
    [self initMineTableView];
}

- (void)updatePage {
    [Public loadWebImage:self.mineModel.merchants_imgs didLoad:^(UIImage * _Nonnull image) {
        self.headView.headImage = image;
    }];
    self.headView.name = self.mineModel.shop_name;
    
    [self.weekView updateWithData:@[self.mineModel.week_total_orders,self.mineModel.week_total_income]];
    
    self.dataList = @[self.mineModel.merchants_score,self.mineModel.merchants_level];
    self.TVC.dataList = self.dataList;
    [self.TVC.tableView reloadData];
}

//加载数据
- (void)loadData {
    NSArray *shopinfo = [Interface mappgetshopinfo];
    [MyNetworker POST:shopinfo[InterfaceUrl] parameters:shopinfo[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            NSDictionary *dict = responseObject;
            
            self.mineModel = [[MineModel alloc] initWithDict:dict];
            
            for (NSString *key in dict.allKeys) {
                [Public saveValue:dict[key] key:key];
            }
            
            [self updatePage];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)initHeadView {
    self.headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], [DefineValue screenWidth] * 0.35)];
    self.headView.headImage = [UIImage imageNamed:@"头像"];
    self.headView.name = [Interface username];
    [self.view addSubview:self.headView];
}

- (void)initWeekView {
    self.weekView = [[WeekView alloc] initWithFrame:CGRectMake(0, self.headView.frame.size.height + 4, [DefineValue screenWidth], 60)];
    self.weekView.titles = @[@"本周订单(单)",@"本周收入(元)"];
    [self.weekView viewWithData:@[@"0", @"0"]];
    [self.view addSubview:self.weekView];
}

- (void)initMineTableView {
    self.TVC = [[MineTableViewController alloc] init];
    
#pragma mark 点击cell的回调
    __weak typeof(self) weakSelf = self;
    self.TVC.clickCell = ^(NSIndexPath *indexPath) {
        [weakSelf pushWithIndexPath:indexPath];
    };
    
    [self addChildViewController:self.TVC];
    UITableView *tableView = self.TVC.tableView;
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
