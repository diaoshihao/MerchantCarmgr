//
//  CommentViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewController.h"
#import "CustomSegmentControl.h"
#import "CustomScrollView.h"
#import "CommentModel.h"
#import "PhotoPreviewController.h"
#import "Interface.h"
#import "UIViewController+ShowView.h"

@interface CommentViewController () <ImageBroswerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) CustomScrollView *scrollView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户评价";
    [self loadData];
}

- (void)showPage {
    [self initSegmentControl];
    [self initCommentScrollView];;
}

- (void)loadData {
    UIView *progressHUD = [self loading:@"加载中..."];
    [self clickDisable];
    self.allowGesture = NO;
    
    NSArray *comment = [Interface mappgetadvise];
    [MyNetworker POST:comment[InterfaceUrl] parameters:comment[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            
            self.dataArr = [self dataWithDict:responseObject];
            [self showPage];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
    }];
}

- (NSArray *)dataWithDict:(NSDictionary *)dict {
    NSMutableArray *star_1 = [NSMutableArray new];
    NSMutableArray *star_2 = [NSMutableArray new];
    NSMutableArray *star_3 = [NSMutableArray new];
    NSMutableArray *star_4 = [NSMutableArray new];
    NSMutableArray *star_5 = [NSMutableArray new];
    
    CommentModel *model = [[CommentModel alloc] initWithDict:dict];
    switch ([dict[@"advise_star"] integerValue]) {
        case 1:
            [star_1 addObject:model];
            break;
        case 2:
            [star_2 addObject:model];
            break;
        case 3:
            [star_3 addObject:model];
            break;
        case 4:
            [star_4 addObject:model];
            break;
        case 5:
            [star_5 addObject:model];
            break;
        default:
            break;
    }
    
    return @[star_5, star_4, star_3, star_2, star_1];
}

- (void)initSegmentControl {
    NSArray *items = @[@"5星",@"4星",@"3星",@"2星",@"1星"];
    self.segment = [[CustomSegmentControl alloc] initWithItems:items];
    self.segment.backgroundColor = [DefineValue separaColor];
    self.segment.tintColor = [DefineValue separaColor];
    [self.segment addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)initCommentScrollView {
    NSMutableArray *views = [NSMutableArray new];
    for (NSInteger i = 0; i < self.segment.numberOfSegments; i++) {
        CommentTableViewController *commentTVC = [[CommentTableViewController alloc] init];
        [self addChildViewController:commentTVC];
        commentTVC.dataArr = [NSMutableArray arrayWithArray:self.dataArr[i]];
        commentTVC.broswerDelegate = self;
        UITableView *tableView = commentTVC.tableView;
        [views addObject:tableView];
    }
    
    self.scrollView = [[CustomScrollView alloc] initWithViews:views];
    self.scrollView.delegate = self;
    CGFloat height = [DefineValue screenHeight] - 64 - 44;
    CGFloat width = [DefineValue screenWidth];
    self.scrollView.singleSize = CGSizeMake(width, height);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - broswer delegate
- (void)showBroserAtIndex:(NSUInteger)index In:(NSArray *)images {
    PhotoPreviewController *previewController = [[PhotoPreviewController alloc] init];
    previewController.photos = images;
    previewController.currentIndex = index;
    previewController.animated = NO;
    [self.navigationController pushViewController:previewController animated:NO];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self selectSegmentIndex:scrollView.contentOffset];
}



- (void)selectAction:(UISegmentedControl *)sender {
    [self scrollToOffset:sender.selectedSegmentIndex];
}

- (void)scrollToOffset:(NSInteger)index {
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.singleSize.width * index, 0);
    }];
}

- (void)selectSegmentIndex:(CGPoint)offset {
    self.segment.selectedSegmentIndex = offset.x / self.scrollView.singleSize.width;
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
