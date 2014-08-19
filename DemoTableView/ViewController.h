//
//  ViewController.h
//  DemoTableView
//
//  Created by For_SHINee on 14-7-16.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollowViewTableViewCell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ScrollowTableCellDelegate>
@property (strong,nonatomic) UITableView *tableView;

@end
