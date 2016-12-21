//
//  MineModel.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "BasicModel.h"

@interface MineModel : BasicModel

@property (nonatomic, strong) NSString *username;//用户的账号
@property (nonatomic, strong) NSString *shop_name;//店铺名称
@property (nonatomic, strong) NSString *week_total_orders;//本周订单量
@property (nonatomic, strong) NSString *week_total_income;//本周收入
@property (nonatomic, strong) NSString *merchants_score;//商家评分
@property (nonatomic, strong) NSString *merchants_level;//商家等级
@property (nonatomic, strong) NSString *account_balance;//账户余额
@property (nonatomic, strong) NSString *deposit;//保证金
@property (nonatomic, strong) NSString *merchants_introduce;//企业简介
@property (nonatomic, strong) NSString *merchants_imgs;//企业照片
@property (nonatomic, strong) NSString *system_message;//系统消息（暂时空）

@end
