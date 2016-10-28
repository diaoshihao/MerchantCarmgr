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

typedef NS_ENUM(NSUInteger, DataState) {
    ToDo = 0,//未解决
    Done,    //已解决
};

@interface ComplaintViewController ()

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) ComplaintTableViewController *complaintTVC;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"投诉处理";
    [self showPage];
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
    self.complaintTVC.dataArr = self.dataArr;
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
    NSDictionary *dict = @{@"userName":@"易务车宝",@"time":@"10月15日",@"imageUrl":@"默认头像",@"text":@"赶快赶快看看我赶快看看我们更新了什么吧们更新了什么吧看看我们更赶快看赶快看看我赶快看看我们更新了什么吧们更新了什么吧看我们更新赶快看看我们更新了什么吧了什么吧新了赶快看看我们更新了什么吧什么吧"};
    ComplaintModel *model = [[ComplaintModel alloc] initWithDict:dict];
    NSDictionary *dict1 = @{@"userName":@"易务车宝",@"time":@"10月16日",@"imageUrl":@"默认头像",@"text":@"赶快赶快看看我赶快看看我们更新了什么吧们更新了什么吧看看我们更赶快看赶快看看我赶快看看我们么吧"};
    ComplaintModel *model1 = [[ComplaintModel alloc] initWithDict:dict1];
    
    
    self.dataArr = [NSMutableArray arrayWithObjects:model, model, model, model,  model1, nil];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
