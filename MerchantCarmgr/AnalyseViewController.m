//
//  AnalyseViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AnalyseViewController.h"
#import "AnalyseModel.h"
#import "AnalyseView.h"
#import "Interface.h"
#import "UIViewController+ShowView.h"

@interface AnalyseViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) AnalyseView *analyse;

@end

@implementation AnalyseViewController

- (void)loadData {
    UIView *progressHUD = [self loading:@"加载中..."];
    [self clickDisable];
    self.allowGesture = NO;
    
    NSArray *analyse = [Interface mappgetstatisticsData_time:@""];
    [MyNetworker POST:analyse[InterfaceUrl] parameters:analyse[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            AnalyseModel *model = [[AnalyseModel alloc] initWithDict:responseObject];
            self.analyse.dataArr = @[@[model.total_subscribe,model.total_access,model.total_communicate],@[model.day_total_subscribe,model.month_total_subscribe],@[model.day_total_order,model.month_total_order],@[model.fatch_cash_total,model.account_balance],@[model.evaluate_start_1,model.evaluate_start_2,model.evaluate_start_3,model.evaluate_start_4,model.evaluate_start_5]];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据统计";
    [self loadData];
    [self showPage];
}

- (void)showPage {
    [self initContentView];
    [self addViews];
}

- (void)initContentView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo([DefineValue screenWidth]);
    }];
}

- (void)addViews {
    self.analyse = [[AnalyseView alloc] init];
    [self.contentView addSubview:self.analyse];
    
    [self.analyse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
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
