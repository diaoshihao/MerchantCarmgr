//
//  InheritForEnterViewController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

/******************************************************
 给登录和入驻页的继承类
 *****************************************************/

#import "CustomBarViewController.h"

@interface InheritForEnterViewController : CustomBarViewController

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIView *separatorView;




@end
