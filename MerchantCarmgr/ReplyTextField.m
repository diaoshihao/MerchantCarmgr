//
//  ReplyTextField.m
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "ReplyTextField.h"
#import "DefineValue.h"

@implementation ReplyTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setting];
    }
    return self;
}

- (void)setting {
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [DefineValue separaColor].CGColor;
    self.returnKeyType = UIReturnKeySend;
    self.enablesReturnKeyAutomatically = YES;
    self.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    self.reply(textField.text);
    textField.text = nil;
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
