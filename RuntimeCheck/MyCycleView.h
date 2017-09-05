//
//  MyCycleView.h
//  RuntimeCheck
//
//  Created by YXY on 2017/9/4.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCycleClickDelegate <NSObject>

- (void)clickCurrentIndex:(NSInteger)index;

@end


@interface MyCycleView : UIView

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) NSArray *imagesArr;
@property (nonatomic, assign) NSTimeInterval cycleTime;
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)images;

@end
