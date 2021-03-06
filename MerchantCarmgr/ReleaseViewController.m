//
//  ReleaseViewController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ReleaseViewController.h"
#import "GeneralControl.h"
#import "CustomTextView.h"
#import "EnterView.h"
#import "ChooseServiceViewController.h"
#import <TZImagePickerController.h>
#import "PhotoPreviewController.h"
#import "UIViewController+ShowView.h"
#import "Interface.h"
#import <Photos/PHAsset.h>
#import "IssueViewController.h"

@interface ReleaseViewController () <TZImagePickerControllerDelegate>
{
    CGFloat _imageWidth;
}

@property (nonatomic, strong) UITextField *titleTextField;

@property (nonatomic, strong) CustomTextView *detailTextField;

@property (nonatomic, strong) UIView *backView; //image's superview

@property (nonatomic, strong) UIButton *pick;

@property (nonatomic, strong) UIButton *chooseService;

@property (nonatomic, strong) UITextField *priceTextField;

@property (nonatomic, strong) UITextField *scopeTextField;

@property (nonatomic, strong) NSMutableArray *textFields;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *photos;//photos did pick
@property (nonatomic, strong) NSMutableArray *photosName;

@end

@implementation ReleaseViewController

- (NSMutableArray *)photos {
    if (_photos == nil) {
        _photos = [NSMutableArray new];
    }
    return _photos;
}

- (NSMutableArray *)photosName {
    if (_photosName == nil) {
        _photosName = [NSMutableArray new];
    }
    return _photosName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布服务";
    [self addObserver];
    [self showPage];
}

//解决键盘遮挡问题
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//在dealloc里销毁可避免用户取消侧滑手势时通知已被销毁
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showPage {
    [self initContentView];
    [self initTitleTextField];
    [self initDetailTextView];
    [self initPickPhotoButton];
    [self initChooseView];
    [self initReleaseButton];
}

- (void)addRightItemButton {
    self.rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightItemButton setTitle:@"我的发布" forState:UIControlStateNormal];
    [self.rightItemButton setTitleColor:[DefineValue mainColor] forState:UIControlStateNormal];
    self.rightItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightItemButton.titleLabel.font = [DefineValue font16];
    [self.rightItemButton addTarget:self action:@selector(showMyIssue) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.rightItemButton];
    [self.rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(44);
    }];
}

- (void)showMyIssue {
    IssueViewController *issueVC = [[IssueViewController alloc] init];
    [self.navigationController pushViewController:issueVC animated:YES];
}

- (void)initContentView {
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [DefineValue separaColor];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo([DefineValue screenWidth]);
    }];
}

- (void)initTitleTextField {
    self.titleTextField = [GeneralControl twoSpaceTextField:@"标题内容"];
    [self.contentView addSubview:self.titleTextField];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset([DefineValue pixHeight] * 2);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)initDetailTextView {
    self.detailTextField = [[CustomTextView alloc] init];
    self.detailTextField.placeholder = @"服务内容";
    [self.contentView addSubview:self.detailTextField];
    [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTextField.mas_bottom).offset([DefineValue pixHeight] * 2);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo([DefineValue screenWidth] * 0.3);
    }];
}

- (void)initPickPhotoButton {
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailTextField.mas_bottom);
        make.left.and.right.mas_equalTo(0);
    }];
    
    self.pick = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pick setBackgroundImage:[UIImage imageNamed:@"选取图片"] forState:UIControlStateNormal];
    [self.pick addTarget:self action:@selector(pickPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.pick];
    
    _imageWidth = ([DefineValue screenWidth] - 25) / 4;
    [self.pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.and.height.mas_equalTo(_imageWidth);
        make.bottom.mas_equalTo(-10);
    }];
    
}

- (void)initChooseView {
    self.textFields = [NSMutableArray new];
    NSArray *titles = @[@"价格", @"服务类型", @"服务范围"];
    NSArray *placeholders = @[@"请输入价格", @"选择", @"请输入服务范围"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UITextField *textField =[EnterView textFieldWithLabelText:titles[i] placeholder:placeholders[i]];
        if (i == 1) {
            textField.placeholder = nil;
            [self chooseButtonAt:textField];
        }
        [self.contentView addSubview:textField];
        
        CGFloat topOffset = 10 + i * (44 + 2 * [DefineValue pixHeight]);
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backView.mas_bottom).offset(topOffset);
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        [self.textFields addObject:textField];
    }
    
    self.priceTextField = self.textFields[0];
    self.scopeTextField = self.textFields[2];
}

- (void)chooseButtonAt:(UITextField *)textField {
    self.chooseService = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseService setTitle:@"选择" forState:UIControlStateNormal];
    [self.chooseService setTitleColor:kColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.chooseService.titleLabel.font = [DefineValue font14];
    [self.chooseService addTarget:self action:@selector(chooseServiceAction) forControlEvents:UIControlEventTouchUpInside];
    [textField addSubview:self.chooseService];
    CGFloat widthOffset = textField.leftView.intrinsicContentSize.width + 40;
    [self.chooseService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(textField.mas_left).offset(widthOffset);
        make.height.mas_equalTo(44);
    }];
}

- (void)initReleaseButton {
    UIButton *release = [GeneralControl loginTypeButton:@"发布"];
    [release addTarget:self action:@selector(releaseService) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:release];
    [release mas_makeConstraints:^(MASConstraintMaker *make) {
        UITextField *textField = self.textFields.lastObject;
        make.top.mas_equalTo(textField.mas_bottom).offset(50);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-44);
    }];
}

#pragma mark - 事件

//选取图片
- (void)pickPhoto {
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        [self.photos addObjectsFromArray:photos];
        for (PHAsset *asset in assets) {
            [self.photosName addObject:[self stringWithDate:asset.creationDate]];
        }
        [self addImagesFromPicker:self.photos];
    }];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//将日期转为NSString     如果不设置格式，返回null  setDateFormat
- (NSString *)stringWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    return [formatter stringFromDate:date];
}

//把选取的图片加到页面
- (void)addImagesFromPicker:(NSArray<UIImage *> *)photos {
    for (UIView *subview in self.backView.subviews) {
        if (![subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    UIImageView *lastImage = nil;
    NSInteger lastIndex = 0;
    for (NSInteger i = 0; i < photos.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = photos[i];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewPhotos:)];
        [imageView addGestureRecognizer:tap];
        [self.backView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo((_imageWidth + 5) * (i / 4) + 5);
            make.left.mas_equalTo((_imageWidth + 5) * (i % 4) + 5);
            make.width.and.height.mas_equalTo(_imageWidth);
        }];
        lastImage = imageView;
        lastIndex = i;
    }
    [self.pick mas_remakeConstraints:^(MASConstraintMaker *make) {
        if ((lastIndex + 1) % 4 == 0) {
            make.top.mas_equalTo(lastImage.mas_bottom).offset(5);
            make.left.mas_equalTo(5);
        } else {
            make.top.mas_equalTo(lastImage.mas_top);
            make.left.mas_equalTo(lastImage.mas_right).offset(5);
        }
        make.width.and.height.mas_equalTo(_imageWidth);
        make.bottom.mas_equalTo(-10);
    }];
}

//点击进入图片预览
- (void)previewPhotos:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    PhotoPreviewController *PhotoPreview = [[PhotoPreviewController alloc] init];
    PhotoPreview.photos = self.photos;
    PhotoPreview.animated = NO;
    PhotoPreview.currentIndex = [self.photos indexOfObject:imageView.image];
    [self.navigationController pushViewController:PhotoPreview animated:NO];
}

//选择服务
- (void)chooseServiceAction {
    ChooseServiceViewController *chooseServiceVC = [[ChooseServiceViewController alloc] init];
    chooseServiceVC.serviceBlock = ^(NSArray *services) {
        NSString *serviceStr = [services componentsJoinedByString:@" "];
        [self.chooseService setTitle:serviceStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:chooseServiceVC animated:YES];
}

/**
 * 发布服务之前先上传图片获取图片路径
 * 路径返回后作为其中一个参数请求发布服务内容
 */
- (void)releaseService {
    if (![self allDone]) {//信息不完整
        return;
    }
    
    if (self.photos.count == 0) {//不添加图片
        [self releaseContentText:@""];
    } else {
        [self uploadImage];//先完成上传图片
    }
}

//上传图片
- (void)uploadImage {
    UIView *progressHUD = [self loading:@"正在上传图片"];
    [self clickDisable];
    self.allowGesture = NO;
    
    NSArray *upload = [Interface mappupload:self.photos.count imageType:Service_introduce_img];
    [MyNetworker uploadWithURL:upload[InterfaceUrl] parameters:upload[Parameters] images:self.photos name:@"file" fileName:self.photosName mimeType:@"jpeg" progress:^(NSProgress *progress) {
        
    } success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            //获取图片路径
            NSMutableArray *imagepaths = [NSMutableArray new];
            for (NSDictionary *dict in responseObject[@"file_store_list"]) {
                [imagepaths addObject:dict[@"store_path"]];
            }
            //如果有多个图片路径，用^将imagepath拼接起来作为参数
            NSString *imagepath = [imagepaths componentsJoinedByString:@"^"];
            //发布服务
            [self releaseContentText:imagepath];
        }
        
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
    }];
}

//发布服务
- (void)releaseContentText:(NSString *)imagepath {
    NSArray *release = [Interface mapppubservicesName:self.titleTextField.text detail:self.detailTextField.text price:self.priceTextField.text type:self.chooseService.currentTitle scope:self.scopeTextField.text imgpath:imagepath];
    
    UIView *progressHUD = [self loading:@"正在发布"];
    [self clickDisable];
    self.allowGesture = NO;
    
    [MyNetworker POST:release[InterfaceUrl] parameters:release[Parameters] success:^(id responseObject) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        
        if ([responseObject[@"opt_state"] isEqualToString:@"success"]) {
            [self success:@"发布成功" dismiss:2];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showAlertMessage:@"发布失败，请重试"];
        }
    } failure:^(NSError *error) {
        [progressHUD removeFromSuperview];
        [self clickEnable];
        self.allowGesture = YES;
        [self connectError];
    }];
}

//判断信息完整度
- (BOOL)allDone {
    if (self.titleTextField.text.length == 0 || self.detailTextField.text.length == 0 || self.priceTextField.text.length == 0 || self.scopeTextField.text.length == 0 || [self.chooseService.currentTitle isEqualToString:@"选择"]) {
        [self showAlertMessage:@"信息不全，请填写完整后再试"];
        return NO;
    }
    return YES;
}

//键盘遮挡响应函数
- (void)keyboardWillShow:(NSNotification *)notification {
    //keyboard height
    CGFloat kbHight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //keyboard time
    CGFloat time = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if ([self.titleTextField isFirstResponder]) {
        return;
    }
    
    CGFloat delta = -44;
    if (![self.detailTextField isFirstResponder]) {
        delta = -kbHight;
    }
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(delta);
    }];
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    //keyboard time
    CGFloat time = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
    }];
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
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
