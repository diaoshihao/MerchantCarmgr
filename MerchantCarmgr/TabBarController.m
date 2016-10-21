//
//  TabBarController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "TabBarController.h"
#import "WorkSpaceViewController.h"
#import "IssueViewController.h"
#import "AppointmentViewController.h"
#import "MineViewController.h"
#import "DefineValue.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customTabBar];
    [self addViewController];
}

//改变tabbar高度
- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 49;
    tabFrame.origin.y = self.view.frame.size.height - 49;
    self.tabBar.frame = tabFrame;
}

- (void)customTabBar {
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[DefineValue mainColor]} forState:UIControlStateSelected];
}

- (UINavigationController *)navigationControllerWithRoot:(NSString *)className title:(NSString *)title images:(NSArray <NSString *>*)images {
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationVC.tabBarItem.title = title;
    navigationVC.tabBarItem.image = [[UIImage imageNamed:images[0]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationVC.tabBarItem.selectedImage = [[UIImage imageNamed:images[1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return navigationVC;
}

- (void)addViewController {
    NSArray *itemTitles = @[@"工作台", @"发布管理", @"预约管理", @"我的"];
    NSArray *images = @[@[@"工作台",@"工作台橙"],
                        @[@"发布",@"发布橙"],
                        @[@"预约",@"预约橙"],
                        @[@"我的",@"我的橙"]];
    NSArray *classes = @[@"WorkSpaceViewController",
                         @"IssueViewController",
                         @"AppointmentViewController",
                         @"MineViewController"];
    NSMutableArray *viewControllers = [NSMutableArray new];
    for (NSInteger i = 0; i < itemTitles.count; i++) {
        UINavigationController *navigation = [self navigationControllerWithRoot:classes[i] title:itemTitles[i] images:images[i]];
        [viewControllers addObject:navigation];
    }
    self.viewControllers = viewControllers;
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
