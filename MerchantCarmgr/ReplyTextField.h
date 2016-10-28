//
//  ReplyTextField.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Reply)(NSString *text);

@interface ReplyTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, copy) Reply reply;

@end
