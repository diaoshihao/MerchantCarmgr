//
//  CommentTableViewController.h
//  MerchantCarmgr
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageBroswerDelegate <NSObject>

- (void)showBroserAtIndex:(NSUInteger)index In:(NSArray *)images;

@end

@interface CommentTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, weak) id <ImageBroswerDelegate> broswerDelegate;

@end
