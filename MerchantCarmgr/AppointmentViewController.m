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
#import "AppointModel.h"

@interface AppointmentViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) CustomScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation AppointmentViewController

- (void)loadData {
    NSDictionary *dict = @{@"state":@"0",@"order":@"ASDFGHJKL",@"headImage":@"",@"name":@"test",@"call":@"12346789",@"photoView":@"",@"title":@"易务车宝测试",@"time":@"2016.11.01",@"count":@"1",@"cost":@"1000.00"};
    NSDictionary *dict1 = @{@"state":@"1",@"order":@"ASDFGHJKL",@"headImage":@"",@"name":@"test",@"call":@"12346789",@"photoView":@"",@"title":@"易务车宝测试",@"time":@"2016.11.01",@"count":@"1",@"cost":@"1000.00"};
    NSDictionary *dict2 = @{@"state":@"2",@"order":@"ASDFGHJKL",@"headImage":@"",@"name":@"test",@"call":@"12346789",@"photoView":@"",@"title":@"易务车宝测试",@"time":@"2016.11.01",@"count":@"1",@"cost":@"1000.00"};
    AppointModel *model = [[AppointModel alloc] initWithDict:dict];
    AppointModel *model1 = [[AppointModel alloc] initWithDict:dict1];
    AppointModel *model2 = [[AppointModel alloc] initWithDict:dict2];
    NSArray *all = @[model,model1,model2];
    NSArray *my = @[model];
    NSArray *doing = @[model1];
    NSArray *done = @[model2];
    self.dataArr = [NSMutableArray arrayWithArray:@[all,my,doing,done]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseSetting];
    [self loadData];
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
        appointTVC.dataArr = self.dataArr[i];
        UITableView *tableView = appointTVC.tableView;
        [self addChildViewController:appointTVC];
        [views addObject:tableView];
    }
    
    self.scrollView = [[CustomScrollView alloc] initWithViews:views];
    self.scrollView.delegate = self;
    CGFloat height = [DefineValue screenHeight] - 64 - 44 - 49;
    CGFloat width = [DefineValue screenWidth];
    self.scrollView.singleSize = CGSizeMake(width, height);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-49);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self selectSegmentIndex:scrollView.contentOffset];
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
