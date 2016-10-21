//
//  UploadImageView.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "UploadImageView.h"
#import "DefineValue.h"

@implementation UploadImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = kColor(204, 204, 204, 1);
    self.userInteractionEnabled = YES;
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnWidth = 20.0;
    self.deleteBtn.frame = CGRectMake(self.frame.size.width - btnWidth, 0, btnWidth, btnWidth);
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"button_download_cancel"] forState:UIControlStateNormal];
    self.deleteBtn.hidden = YES;
    [self.deleteBtn addTarget:self action:@selector(deleteImageFromImageView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}

- (void)deleteImageFromImageView {
    self.deleteBtn.hidden = YES;
    self.image = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
