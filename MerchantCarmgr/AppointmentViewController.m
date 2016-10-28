//
//  AppointmentViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AppointmentViewController.h"
#import "CustomSegmentControl.h"
#import "CustomScrollView.h"
#import "AppointTableViewController.h"

@interface AppointmentViewController ()

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) CustomScrollView *scrollView;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseSetting];
    [self showPage];
}

- (void)baseSetting {
    self.title = @"预约管理";
    self.barTitleLabel.textColor = [UIColor whiteColor];
}

- (void)showPage {
    [self initSegmentControl];
    [self initAppointPage];
}

- (void)initSegmentControl {
    NSArray *items = @[@"全部",@"我的预约",@"进行中",@"已完成"];
    self.segment = [[CustomSegmentControl alloc] initWithItems:items];
    [self.segment addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)initAppointPage {
    NSMutableArray *views = [NSMutableArray new];
    for (NSInteger i = 0; i < self.segment.numberOfSegments; i++) {
        AppointTableViewController *appointTVC = [[AppointTableViewController alloc] init];
        UITableView *tableView = appointTVC.tableView;
        [views addObject:tableView];
    }
    
    self.scrollView = [[CustomScrollView alloc] initWithViews:views];
    CGFloat height = [DefineValue screenHeight] - 64 - 44 - 49;
    CGFloat width = [DefineValue screenWidth];
    self.scrollView.singleSize = CGSizeMake(width, height);
    __weak typeof(self) weakSelf = self;
    self.scrollView.didScroll = ^(CGPoint offset) {
        [weakSelf selectSegmentIndex:offset];
    };
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-49);
    }];
}

- (void)selectAction:(UISegmentedControl *)sender {
    [self scrollToOffset:sender.selectedSegmentIndex];
}

- (void)scrollToOffset:(NSInteger)index {
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake([DefineValue screenWidth] * index, 0);
    }];
}

- (void)selectSegmentIndex:(CGPoint)offset {
    self.segment.selectedSegmentIndex = offset.x / [DefineValue screenWidth];
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
