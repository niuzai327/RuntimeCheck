//
//  MyTableView.h
//  RuntimeCheck
//
//  Created by YXY on 2017/9/1.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTableView;

@protocol MyTableViewDelegate <NSObject,UIScrollViewDelegate>
- (CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol MyTableViewDataSource <NSObject>

- (NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyTableView : UIScrollView

@property (nonatomic, weak) id<MyTableViewDelegate> delegate;
@property (nonatomic, weak) id<MyTableViewDataSource> dataSource;

- (void)reloadData;

- (id)dequeueReusableCellWithIdentifrier:(NSString *)identifier;

@end
