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

@interface CommentViewController () <ImageBroswerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) CustomSegmentControl *segment;

@property (nonatomic, strong) CustomScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户评价";
    [self loadData];
    [self showPage];
}

- (void)showPage {
    [self initSegmentControl];
    [self initCommentScrollView];;
}

- (void)loadData {
    CommentModel *model = [[CommentModel alloc] init];
    model.userName = @"123456789";
    model.images = @[@"发布管理附图",@"发布管理附图",@"发布管理附图"];
    model.score = @"5";
    model.time = @"2016.10.25";
    model.comment = @"懂哈嘎搞好规划上帝会啊哈刚好盖过哈哥和嘎斯韩国啊哈哥过哈哥湿地恢复是德国怕黄瓜片都会是个送给洪水过后送关怀送韩国手工还送关怀手工哈工大洪水给我哦关怀问候给我后悔我好";
    model.answers = @[@"搞好规划上帝会啊哈刚好盖过哈哥和嘎斯韩国啊哈哥过哈哥湿地恢复是德国怕黄瓜片都会是个",@"搞好规划上帝会啊哈刚好盖过哈哥和嘎斯韩国啊哈哥过哈哥湿地恢复是德国怕黄瓜片都会是个"];
    NSArray *data = @[@[model,model,model,model,model],@[model,model],@[model],@[model,model],@[model]];
    self.dataArr = [NSMutableArray arrayWithArray:data];
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
