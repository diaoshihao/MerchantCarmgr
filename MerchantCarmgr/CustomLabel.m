//
//  CustomLabel.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/24.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel


- (void)setText:(NSString *)text {
    [super setText:text];
    [self setTextAttribute];
}

- (void)setTextAttribute {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:_lineSpace];
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
