//
//  MineTableViewController.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/19.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCell)(NSIndexPath *indexPath);

@interface MineTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, copy) ClickCell clickCell;

@end
