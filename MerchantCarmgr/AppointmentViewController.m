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
#import "UIViewController+ShowView.h"

#import "Interface.h"

@interface AppointmentViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) CustomScrollView *scrollView;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSMutableArray *childVC;

@property (nonatomic, strong) NSMutableArray *all;
@property (nonatomic, strong) NSMutableArray *my;
@property (nonatomic, strong) NSMutableArray *doing;
@property (nonatomic, strong) NSMutableArray *done;

@end

@implementation AppointmentViewController

- (NSMutableArray *)childVC {
    if (_childVC == nil) {
        _childVC = [NSMutableArray new];
    }
    return _childVC;
}

- (NSMutableArray *)all {
    if (_all == nil) {
        _all = [NSMutableArray new];
    }
    return _all;
}
- (NSMutableArray *)my {
    if (_my == nil) {
        _my = [NSMutableArray new];
    }
    return _my;
}
- (NSMutableArray *)doing {
    if (_doing == nil) {
        _doing = [NSMutableArray new];
    }
    return _doing;
}
- (NSMutableArray *)done {
    if (_done == nil) {
        _done = [NSMutableArray new];
    }
    return _done;
}

- (void)loadData {
    UIView *progressHUD = [self loading:@"加载中..."];
    [self clickDisable];
    
    NSArray *subscribe = [Interface mappgetsubscribe];
    [MyNetworker POST:subscribe[InterfaceUrl] parameters:subscribe[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self.all removeAllObjects];
            [self.my removeAllObjects];
            [self.doing removeAllObjects];
            [self.done removeAllObjects];
            
            for (NSDictionary *dict in responseObject[@"services_list"]) {
                AppointModel *model = [[AppointModel alloc] initWithDict:dict];
                [self.all addObject:model];
                
                if ([model.subscribe_state isEqualToString:@"0"]) {
                    [self.my addObject:model];
                }
                
                if ([model.subscribe_state isEqualToString:@"1"]) {
                    [self.doing addObject:model];
                }
                
                if ([model.subscribe_state isEqualToString:@"2"]) {
                    [self.done addObject:model];
                }
            }
            
            self.dataArr = @[self.all,self.my,self.doing,self.done];
            
            [self showPage];
        } else {
            [self noDataPage];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        [self noDataPage];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseSetting];
    [self loadData];
}

- (void)baseSetting {
    self.title = @"预约管理";
    self.barTitleLabel.textColor = [UIColor whiteColor];
}

- (void)showPage {
    [self initSegmentControl];
    [self initAppointPage];
}

- (void)noDataPage {
    [self initSegmentControl];
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
    NSMutableArray *tableViews = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < self.segment.numberOfSegments; i++) {
        AppointTableViewController *appointTVC = [[AppointTableViewController alloc] init];
        appointTVC.dataArr = self.dataArr[i];
        [self addChildViewController:appointTVC];
        [self.childVC addObject:appointTVC];
        
        UITableView *tableView = appointTVC.tableView;
        [tableViews addObject:tableView];
    }
    
    self.scrollView = [[CustomScrollView alloc] initWithViews:tableViews];
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
