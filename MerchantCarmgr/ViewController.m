//
//  ViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ViewController.h"
#import "BasicNavigationController.h"
#import "EnterViewController.h"
#import "TabBarController.h"
#import "GuidePageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    [self showPage];
}

- (void)showPage {
    if ([self isFirstLuanch]) {
        [self showGuidePage];//首次使用
    }
    else if ([self userDidLogin]) {
        [self showHomePage];//已自动登录
    }
    else {
        [self showLoginPage];
    }
}

//显示引导页
- (void)showGuidePage {
    GuidePageViewController *guideVC = [[GuidePageViewController alloc] init];
    [self addChildViewController:guideVC];
    [self.view addSubview:guideVC.view];
}

//显示首页
- (void)showHomePage {
    TabBarController *tabBarVC = [[TabBarController alloc] init];
    [self addChildViewController:tabBarVC];
    [self.view addSubview:tabBarVC.view];
}

//显示登录页
- (void)showLoginPage {
    EnterViewController *enterVC = [[EnterViewController alloc] init];
    BasicNavigationController *enterNav = [[BasicNavigationController alloc] initWithRootViewController:enterVC];
    [self addChildViewController:enterNav];
    [self.view addSubview:enterNav.view];
}

//判断是否使用新版本
- (BOOL)isFirstLuanch {
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if ([version isEqualToString:savedVersion]) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
        return YES;
    }
}

//判断用户是否自动登录
- (BOOL)userDidLogin {
    /**
     * code
     */
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
