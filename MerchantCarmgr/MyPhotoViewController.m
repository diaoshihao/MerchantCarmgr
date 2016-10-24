//
//  MyPhotoViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MyPhotoViewController.h"
#import "GeneralControl.h"

@interface MyPhotoViewController ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation MyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"企业照片";
    [self showPage];
}

- (void)showPage {
    [self addPickerButton];
    [self initButtons];
}

- (void)addPickerButton {
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    self.addButton.backgroundColor = [UIColor whiteColor];
    self.addButton.tag = 20;
    [self.addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.text = @"标准尺寸位 750X350 且最多可上传3张";
    [self.view addSubview:self.tipsLabel];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset(30);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(self.addButton.mas_width).multipliedBy(35.0 / 75.0);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addButton.mas_bottom);
        make.centerX.mas_equalTo(self.addButton);
        make.height.mas_equalTo(44);
    }];
}

- (void)initButtons {
    NSArray *titles = @[@"上传", @"预览"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [GeneralControl loginTypeButton:titles[i]];
        button.tag = i + 10;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat topOffset = 60 + i * (44 + 20);
            make.top.mas_equalTo(self.tipsLabel.mas_bottom).offset(topOffset);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(44);
        }];
    }
}

- (void)buttonClick:(UIButton *)sender {
    if (sender.tag == 20) {
        [self pickPhotos];
    } else if (sender.tag == 10) {
        [self uploadPhotos];
    } else if (sender.tag == 11) {
        [self previewPhotos];
    } else {
        return;
    }
}

//选择图片
- (void)pickPhotos {
    
}

//上传图片
- (void)uploadPhotos {
    
}

//预览图片
- (void)previewPhotos {
    
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
