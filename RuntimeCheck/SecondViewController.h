//
//  SecondViewController.h
//  RuntimeCheck
//
//  Created by YXY on 2017/8/28.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) NSString *str;
@property (nonatomic, strong) UITableView *tableView;

@end
