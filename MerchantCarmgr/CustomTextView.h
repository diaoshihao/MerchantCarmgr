//
//  ReleaseTextView.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnText)(NSString *text);

@interface CustomTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@property (nonatomic, copy) ReturnText returnBlock;

@end
