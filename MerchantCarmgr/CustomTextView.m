//
//  ReleaseTextView.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomTextView.h"
#import "DefineValue.h"

@interface CustomTextView() <UITextViewDelegate>

@end

@implementation CustomTextView

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setting];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self settingParagraphStyle];
    }
    return self;
}

- (void)setting {
    self.textColor = [DefineValue fieldColor];
    self.text = _placeholder;
    self.font = [DefineValue font15];
    self.delegate = self;
    self.textContainerInset = UIEdgeInsetsMake(10, 20, 10, 20);
    self.enablesReturnKeyAutomatically = YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.textColor = kColor(102, 102, 102, 1);
    if ([textView.text isEqualToString:_placeholder]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.textColor = [DefineValue fieldColor];
        textView.text = _placeholder;
    }
}

- (void)settingParagraphStyle {
    //    textview 改变字体的行间距
    _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    _paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[DefineValue font15],
                                 NSParagraphStyleAttributeName:_paragraphStyle
                                 };
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
}

- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle {
    _paragraphStyle = paragraphStyle;
    [self settingParagraphStyle];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
