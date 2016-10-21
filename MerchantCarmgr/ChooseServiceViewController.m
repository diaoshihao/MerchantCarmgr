//
//  ChooseServiceViewController.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ChooseServiceViewController.h"
#import "ChooseServiceModel.h"

@interface ChooseServiceViewController () <UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) UIButton *rightItemButton;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ChooseServiceViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择服务";
    [self settingRightItemButton];
    [self initAndLaoutSubViews];
}

- (void)settingRightItemButton {
    self.rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightItemButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightItemButton setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    self.rightItemButton.titleLabel.font = [DefineValue font14];
    self.rightItemButton.hidden = YES;
    [self.rightItemButton addTarget:self action:@selector(chooseServiceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.customNavBar);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
}

- (void)initAndLaoutSubViews {
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [DefineValue separaColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo([DefineValue screenWidth]);
        make.height.mas_equalTo(44);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"可多选";
    label.textColor = [DefineValue buttonColor];
    label.font = [DefineValue font12];
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    NSArray *names = @[@"上牌",@"驾考",@"车险",@"检车",@"维修",@"租车",@"保养",@"二手车",@"车贷",@"新车",@"急救",@"用品"];
    for (NSString *string in names) {
        NSDictionary *dict = @{@"name":string};
        ChooseServiceModel *model = [[ChooseServiceModel alloc] initWithDict:dict];
        [self.dataArray addObject:model];
    }
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.allowsMultipleSelection = YES;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.tintColor = [DefineValue mainColor];
    ChooseServiceModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.accessoryType = model.checked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    [self isHiddenRightButton];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //改变选择状态并替换到数据源中
    ChooseServiceModel *model = self.dataArray[indexPath.row];
    model.checked = !model.checked;
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    [tableView reloadData];
}

- (BOOL)isHiddenRightButton {
    for (ChooseServiceModel *model in self.dataArray) {
        if (model.checked == YES) {
            self.rightItemButton.hidden = NO;
            return NO;
        }
    }
    self.rightItemButton.hidden = YES;
    return YES;
}

- (void)chooseServiceAction {
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (ChooseServiceModel *model in self.dataArray) {
        if (model.checked == YES) {
            [arrM addObject:model.name];
        }
    }
    self.serviceBlock(arrM);
    [self.navigationController popViewControllerAnimated:YES];
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
