//
//  InheritForLeagueViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "InheritForLeagueViewController.h"

@interface InheritForLeagueViewController ()

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation InheritForLeagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"加盟";
    [self initStepButtons];
}

- (EnterStep)enterStep {
    [self changeButtonColorWithStep:_enterStep];
    return _enterStep;
}

- (void)initStepButtons {
    [self separatorViewWithHeight:7 constraintsView:self.customNavBar superView:self.view];
    
    NSArray *titles = @[@"经营者信息",@"商户信息",@"加盟信息"];
    CGFloat buttonWidth = [DefineValue screenWidth] / 3;
    self.buttons = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [self buttonWithTitle:titles[i] frame:CGRectMake(i * buttonWidth, 71, buttonWidth, 44)];
        [self.view addSubview:button];
        [self.buttons addObject:button];
    }
    
    self.separatorView = [self separatorViewWithHeight:7 constraintsView:self.buttons.firstObject superView:self.view];
}


- (UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [EnterView leftTitleAndRightImageButton:title];
    button.frame = frame;
    return button;
}

- (void)changeButtonColorWithStep:(EnterStep)enterStep {
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    UIButton *button = self.buttons[enterStep];
    button.selected = YES;
}

- (UITextField *)customTextFieldWithSeparator:(NSString *)labelTitle placeholder:(NSString *)placeholder superView:(UIView *)superView {
    UITextField *textField = [EnterView textFieldWithLabelText:labelTitle placeholder:placeholder];
    [superView addSubview:textField];
    
    [self separatorViewWithHeight:[DefineValue pixHeight] constraintsView:textField superView:superView];
    return textField;
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
