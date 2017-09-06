//
//  CustomTableView.h
//  RuntimeCheck
//
//  Created by YXY on 2017/9/5.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTableView;
@protocol CustomTableViewDataSource <NSObject>

- (NSInteger)numberOfRows;
- (CGFloat)heightForRowInTableView;
- (UITableViewCell *)tableView:(CustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CustomTableView : UIScrollView

@property (nonatomic, weak) id <CustomTableViewDataSource> dataSource;

- (void)reloadData;

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)indentifier;

@end
