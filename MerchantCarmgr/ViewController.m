//
//  ViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ViewController.h"
#import "EnterViewController.h"
#import "TabBarController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL hasLogin;

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    EnterViewController *enterVC = [[EnterViewController alloc] init];
    UINavigationController *enterNav = [[UINavigationController alloc] initWithRootViewController:enterVC];
    [self addChildViewController:enterNav];
    
    TabBarController *tabBarVC = [[TabBarController alloc] init];
    [self addChildViewController:tabBarVC];
    
    [self hasLoginOrNot];
    
    if (!self.hasLogin) {
        [self transitionFromViewController:tabBarVC toViewController:enterNav duration:0.0 options:UIViewAnimationOptionLayoutSubviews animations:nil completion:nil];
        self.currentViewController = enterNav;
    } else {
        self.currentViewController = tabBarVC;
    }
    
    [self.view insertSubview:self.currentViewController.view atIndex:0];
}

- (void)hasLoginOrNot {
    self.hasLogin = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
