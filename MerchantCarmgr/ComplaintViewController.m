//
//  ComplaintViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ComplaintViewController.h"
#import "CustomSegmentControl.h"
#import "ComplaintTableViewController.h"
#import "ComplaintModel.h"
#import "Interface.h"
#import "UIViewController+ShowView.h"

typedef NS_ENUM(NSUInteger, DataState) {
    ToDo = 0,//未解决
    Done,    //已解决
};

@interface ComplaintViewController ()

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *toDoArr;
@property (nonatomic, strong) NSMutableArray *doneArr;

@property (nonatomic, strong) ComplaintTableViewController *complaintTVC;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ComplaintViewController

- (NSMutableArray *)toDoArr {
    if (_toDoArr == nil) {
        _toDoArr = [NSMutableArray new];
    }
    return _toDoArr;
}

- (NSMutableArray *)doneArr {
    if (_doneArr == nil) {
        _doneArr = [NSMutableArray new];
    }
    return _doneArr;
}

- (void)loadData {
    UIView *progressHUD = [self loading:@"加载中..."];
    [self clickDisable];
    self.allowGesture = NO;
    
    NSArray *complaint = [Interface mappgetcomplaint];
    [MyNetworker POST:complaint[InterfaceUrl] parameters:complaint[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            ComplaintModel *model = [[ComplaintModel alloc] initWithDict:responseObject];
            if ([model.complaint_finish integerValue] == 0) {
                [self.doneArr addObject:model];
            } else {
                [self.toDoArr addObject:model];
            }
            self.dataArr = @[self.toDoArr, self.doneArr];
            [self showPage];
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
    self.title = @"投诉处理";
    [self loadData];
    
}

- (void)showPage {
    [self initSegment];
    [self loadData:ToDo];
    [self settingTableView];
}

- (void)initSegment {
    NSArray *items = @[@"未解决", @"已解决"];
    self.segment = [[CustomSegmentControl alloc] initWithItems:items];
    self.segment.frame = CGRectMake(0, 64, [DefineValue screenWidth], 44);
    self.segment.tintColor = [UIColor clearColor];
    self.segment.backgroundColor = [UIColor clearColor];
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
}

- (void)settingTableView {
    self.complaintTVC = [[ComplaintTableViewController alloc] init];
    self.complaintTVC.dataArr = self.toDoArr;
    [self addChildViewController:self.complaintTVC];
    self.tableView = self.complaintTVC.tableView;
    self.tableView.frame = CGRectMake(0, 108, [DefineValue screenWidth], [DefineValue screenHeight] - 108);
    [self.view addSubview:self.tableView];
}

- (void)segmentAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self loadData:ToDo];
    } else {
        [self loadData:Done];
    }
}

- (void)loadData:(DataState)state {
    self.complaintTVC.dataArr = self.dataArr[state];
    [self.tableView reloadData];
    //如果数据为0，不能执行以下方法，否则crash
//    if (self.complaintTVC.dataArr.count != 0) {
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
//    self.tableView.scrollsToTop = YES;
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
