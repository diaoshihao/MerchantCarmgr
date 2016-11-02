//
//  PhotoBroswerController.m
//  MerchantCarmgr
//
//  Created by admin on 2016/11/1.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "PhotoBroswerController.h"
#import "CustomScrollView.h"
#import "DefineValue.h"
#import <Masonry.h>

@interface PhotoBroswerController () <UIScrollViewDelegate>

@property (nonatomic, strong) CustomScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation PhotoBroswerController

- (instancetype)initWithImages:(NSArray *)images index:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.imageArr = images;
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
}

- (NSMutableArray *)imageViews {
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray new];
    }
    return _imageViews;
}

//设置显示第几张图片
- (void)setIndex:(NSUInteger)index {
    _index = index;
    [self scrollToOffset:index];
}

//设置scrollview偏移
- (void)scrollToOffset:(NSInteger)index {
    self.scrollView.contentOffset = CGPointMake(self.scrollView.singleSize.width * index, 0);
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    [self addImageToScrollView];
}

//添加view到scrollview上
- (void)addImageToScrollView {
    [self initView];//初始化
    
    for (NSInteger i = 0; i < _imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[self imageWith:_imageArr[i]]];
        imageView.contentMode = UIViewContentModeCenter;
        
        //添加点击手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidTap:)];
        [imageView addGestureRecognizer:tap];
        
        [self.imageViews addObject:imageView];
    }
    self.scrollView.views = self.imageViews;
    self.scrollView.singleSize = CGSizeMake([DefineValue screenWidth], [DefineValue screenHeight] - 64 - 49);
}

- (void)imageDidTap:(UITapGestureRecognizer *)tap {
    if (self == self.navigationController.topViewController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

//初始化scrollview
- (void)initView {
    self.scrollView = [[CustomScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-49);
    }];
}

//判断元素类型
- (UIImage *)imageWith:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        return image;
    }
    if ([image isKindOfClass:[NSString class]]) {
        if ([image hasPrefix:@"http"]) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
            return [UIImage imageWithData:imageData];
        } else {
            return [UIImage imageNamed:image];;
        }
    }
    return nil;
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
