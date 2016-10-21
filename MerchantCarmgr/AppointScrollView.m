//
//  AppointScrollView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "AppointScrollView.h"
#import "AppointTableViewController.h"
#import "DefineValue.h"

@interface AppointScrollView() <UIScrollViewDelegate>

@end

@implementation AppointScrollView

- (void)loadData {
    CGFloat height = [DefineValue screenWidth] - 64 - 44 - 49;
//    NSArray *array = @[self.allAppointArr,self.myAppointArr,self.ongoingArr,self.completedArr];
    for (NSInteger i = 0; i < 4; i++) {
        AppointTableViewController *appointTVC = [[AppointTableViewController alloc] init];
        UITableView *tableView = appointTVC.tableView;
        tableView.backgroundColor = [DefineValue separaColor];
        tableView.frame = CGRectMake([DefineValue screenWidth] * i, 0, [DefineValue screenWidth], height);
        [self addSubview:tableView];
    }
    
    self.delegate = self;
    self.contentSize = CGSizeMake([DefineValue screenWidth] * 4, 0);
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.didScroll(scrollView.contentOffset);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
