//
//  SettingViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "SettingViewController.h"
#import "GeneralControl.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation SettingViewController

- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = @[@"清除缓存",@"推送消息",@"账号绑定",@"评价我们",@"意见反馈",@"关于易务车宝"];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self showPage];
}

- (void)showPage {
    [self initTableView];
    [self initLogoutButton];
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(69);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44 * self.dataArr.count);
    }];
}

- (UIButton *)logoutButton {
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.backgroundColor = [UIColor whiteColor];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:[DefineValue buttonColor] forState:UIControlStateNormal];
    logout.layer.cornerRadius = 6;
    return logout;
}

- (void)initLogoutButton {
    UIButton *logout = [self logoutButton];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    if (indexPath.row == 1) {
        [self addSwitchTo:cell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addSwitchTo:(UITableViewCell *)cell {
    UISwitch *cellSwitch = [[UISwitch alloc] init];
    cellSwitch.on = YES;
    cellSwitch.onTintColor = [DefineValue mainColor];
    [cellSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [cell addSubview:cellSwitch];
    [cellSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(cell);
    }];
}

- (void)logout {
    
}

- (void)switchAction:(UISwitch *)sender {
    
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
