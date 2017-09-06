//
//  CustomTableView.m
//  RuntimeCheck
//
//  Created by YXY on 2017/9/5.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "CustomTableView.h"
#import "CustomRowItem.h"
#import "CustomCell.h"
@interface CustomTableView ()

@property (nonatomic, strong) NSMutableArray *rowRecords;
@property (nonatomic, strong) NSMutableDictionary *visibleCells;
@property (nonatomic, strong) NSMutableSet *reusePool;

@end

@implementation CustomTableView

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutTableView];
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)indentifier{
    UITableViewCell *reuseCell = nil;
    for (UITableViewCell *cell in self.reusePool) {
        if ([cell.reuseIdentifier isEqualToString:indentifier]) {
            reuseCell = cell;
            break;
        }
    }
    if (reuseCell) {
        [self.reusePool removeObject:reuseCell];
    }
    return reuseCell;
}

- (void)reloadData{
    [self countRowsPosition];
}

- (void)setContentOffset:(CGPoint)contentOffset{
    [super setContentOffset:contentOffset];
}

- (void)layoutTableView{
    CGFloat startY = self.contentOffset.y;
    CGFloat endY = self.contentOffset.y + self.bounds.size.height;
    NSRange range = [self numberOfRowWillShowInTableView:startY end:endY];
    for (NSUInteger i = range.location; i < range.location + range.length; i ++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.visibleCells objectForKey:@(i)];
        if (cell == nil) {
            cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
            [self.visibleCells setObject:cell forKey:@(i)];
            CustomRowItem *row = self.rowRecords[i];
            cell.frame = CGRectMake(0, row.startY, self.frame.size.width, row.rowHeight);
            [self addSubview:cell];
        }
    }
    NSArray *allVisiableCells = [self.visibleCells allKeys];
    for (NSNumber *number in allVisiableCells) {
        if (!NSLocationInRange([number integerValue], range)) {
            UITableViewCell *cell = [self.visibleCells objectForKey:number];
            [self.reusePool addObject:cell];
            [self.visibleCells removeObjectForKey:number];
            [cell removeFromSuperview];
        }
    }
}

- (void)countRowsPosition{
    
    CGFloat startY = self.contentOffset.y;
    CGFloat totalHeight = startY;
    if ([self.dataSource respondsToSelector:@selector(numberOfRows)]) {
        NSInteger rowCount = [self.dataSource numberOfRows];
        for (int i = 0; i < rowCount; i++) {
            CGFloat height = 44.0;
            if ([self.dataSource respondsToSelector:@selector(heightForRowInTableView)]) {
                height = [self.dataSource heightForRowInTableView];
            }
            totalHeight += height;
            CustomRowItem *row = [[CustomRowItem alloc] init];
            row.startY = startY;
            row.rowHeight = height;
            startY = startY + height;
            [self.rowRecords addObject:row];
        }
    }
    self.contentSize = CGSizeMake(self.frame.size.width, totalHeight);
}

- (NSRange)numberOfRowWillShowInTableView:(CGFloat)startY end:(CGFloat)endY{
    CustomRowItem *startRow = [[CustomRowItem alloc] init];
    startRow.startY = startY;
    CustomRowItem *endRow = [[CustomRowItem alloc] init];
    endRow.startY = endY;
    NSInteger startIndex = [self.rowRecords indexOfObject:startRow inSortedRange:NSMakeRange(0, self.rowRecords.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(CustomRowItem *obj1, CustomRowItem *obj2) {
        if (obj1.startY < obj2.startY) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    if (startIndex > 0) {
        startIndex --;
    }
    NSInteger endIndex = [self.rowRecords indexOfObject:endRow inSortedRange:NSMakeRange(0, self.rowRecords.count-1) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(CustomRowItem *obj1, CustomRowItem *obj2) {
        if (obj1.startY < obj2.startY) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    if (endIndex > 0) {
        endIndex--;
    }
    return NSMakeRange(startIndex, endIndex-startIndex+1);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
