//
//  BasicViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/17.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *stateView;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation BasicViewController

- (void)setTitle:(NSString *)title {
    self.barTitleLabel.text = title;
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.stateView.backgroundColor = backColor;
    self.customNavBar.backgroundColor = backColor;
}

- (void)setAllowGesture:(BOOL)allowGesture {
    _allowGesture = allowGesture;
    self.pan.enabled = allowGesture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [DefineValue separaColor];
    self.navigationController.navigationBarHidden = YES;
    [self customNavigationBar];
    [self addLeftItemButton];
    [self addRightItemButton];
    [self addGestureForRetrun];
    self.allowGesture = YES;
}

- (void)customNavigationBar {
    self.stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [DefineValue screenWidth], 20)];
    self.stateView.backgroundColor = [DefineValue mainColor];
    [self.view addSubview:self.stateView];
    self.customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [DefineValue screenWidth], 44)];
    self.customNavBar.backgroundColor = [DefineValue mainColor];
    [self.view addSubview:self.customNavBar];
    
    self.barTitleLabel = [[UILabel alloc] init];
    [self.customNavBar addSubview:self.barTitleLabel];
    [self.barTitleLabel contentHuggingPriorityForAxis:UILayoutConstraintAxisVertical];
    [self.barTitleLabel contentHuggingPriorityForAxis:UILayoutConstraintAxisHorizontal];
    [self.barTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.customNavBar);
    }];
}

- (void)addLeftItemButton {
    
}
- (void)addRightItemButton {
    
}

- (void)addGestureForRetrun {
    // 获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    self.pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:self.pan];
    
    // 禁止使用系统自带的滑动手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)handleNavigationTransition:(id)target {
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.navigationController.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
