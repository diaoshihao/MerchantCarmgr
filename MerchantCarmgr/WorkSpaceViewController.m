//
//  WorkSpaceViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "WorkSpaceViewController.h"
#import "ADScrollView.h"
#import "DataView.h"
#import "ClickView.h"
#import "AnalyseModel.h"
#import "GeneralControl.h"

#import "ReleaseViewController.h"
#import "AnalyseViewController.h"
#import "CommentViewController.h"
#import "ComplaintViewController.h"

#import "Interface.h"
#import "Public.h"

@interface WorkSpaceViewController ()

@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) ADScrollView *scrollView;

@property (nonatomic, strong) DataView *dataView;

@property (nonatomic, strong) AnalyseModel *model;

@end

@implementation WorkSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self baseSetting];
    [self showPage];
    [self loadData];
}

- (void)baseSetting {
    self.title = @"工作台";
    self.barTitleLabel.textColor = [UIColor whiteColor];
}

- (void)showPage {
    [self initScrollView];
    [self initDataView];
    [self initButtons];
}

//加载数据
- (void)loadData {
    NSArray *shopinfo = [Interface mappgetstatisticsData_time:@""];
    [MyNetworker POST:shopinfo[InterfaceUrl] parameters:shopinfo[Parameters] success:^(id responseObject) {
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            NSDictionary *dict = responseObject;
            
            self.model = [[AnalyseModel alloc] initWithDict:dict];
            
            [self.dataView updateWithData:@[self.model.total_access,self.model.total_subscribe,self.model.total_communicate]];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)initContentView {
    self.contentScroll = [[UIScrollView alloc] init];
    self.contentScroll.backgroundColor = [DefineValue separaColor];
    self.contentScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.contentScroll];
    [self.contentScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [DefineValue separaColor];
    [self.contentScroll addSubview:self.contentView];
    
}

- (void)initScrollView {
    self.scrollView = [[ADScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 64, [DefineValue screenWidth], [DefineValue screenWidth] * 2 / 5);
    self.scrollView.images = @[@"首页大图"];
    self.scrollView.autoScroll = YES;
    [self.view addSubview:self.scrollView];
}

- (void)initDataView {
    self.dataView = [[DataView alloc] init];
    [self.dataView viewWithData:@[@"0",@"0",@"0"]];
    [self.view addSubview:self.dataView];
    [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
}

- (void)initButtons {
    NSArray *titles = @[@"发布服务",@"数据统计",@"用户评价",@"投诉处理"];
    NSArray *images = @[@"发布服务",@"数据统计",@"用户评价",@"投诉处理"];
    
    ClickView *clickView = [[ClickView alloc] init];
    [clickView viewWithTitles:titles images:images];
    [clickView didClickAt:^(NSInteger tag) {
        [self pushWithTag:tag];
    }];
    [self.view addSubview:clickView];
    
    [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataView.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] / 1.5 * 2);
    }];
}

//根据点击的按钮push到对应的控制器
- (void)pushWithTag:(NSInteger)tag {
    if (tag == 100) {
        ReleaseViewController *releaseVC = [[ReleaseViewController alloc] init];
        releaseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:releaseVC animated:YES];
    } else if (tag == 101) {
        AnalyseViewController *analyseVC = [[AnalyseViewController alloc] init];
        analyseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:analyseVC animated:YES];
    } else if (tag == 102) {
        CommentViewController *commentVC = [[CommentViewController alloc] init];
        commentVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:commentVC animated:YES];
    } else if (tag == 103) {
        ComplaintViewController *complaintVC = [[ComplaintViewController alloc] init];
        complaintVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:complaintVC animated:YES];
    } else {
        return;
    }
    
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
