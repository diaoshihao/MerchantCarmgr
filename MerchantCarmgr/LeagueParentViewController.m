//
//  LeagueParentViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LeagueParentViewController.h"
#import "OperatorInfoViewController.h"
#import "MerchantInfoViewController.h"
#import "LeagueInfoViewController.h"

@interface LeagueParentViewController ()

@end

@implementation LeagueParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildVC];
}

- (void)addChildVC {
    OperatorInfoViewController *operatorInfoVC = [[OperatorInfoViewController alloc] init];
    [self addChildViewController:operatorInfoVC];
    
    MerchantInfoViewController *merchantInfoVC = [[MerchantInfoViewController alloc] init];
    [self addChildViewController:merchantInfoVC];
    
    LeagueInfoViewController *leagueInfoVC = [[LeagueInfoViewController alloc] init];
    [self addChildViewController:leagueInfoVC];
    
    [self.view addSubview:operatorInfoVC.view];
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
