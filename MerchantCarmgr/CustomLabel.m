//
//  CustomLabel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomLabel.h"

@interface CustomLabel()

@property (nonatomic, strong) NSDictionary *attributes;

@end

@implementation CustomLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfLines = 0;
    }
    return self;
}

- (void)setLineSpace:(CGFloat)lineSpace {
    _lineSpace = lineSpace;
    [self setTextAttribute];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setTextAttribute];
}


- (void)setTextAttribute {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:_lineSpace];
    self.attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    if (self.text != nil) {
        self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:self.attributes];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
