//
//  MyCycleView.m
//  RuntimeCheck
//
//  Created by YXY on 2017/9/4.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "MyCycleView.h"

#define DefaultCycleTime 2.0

@interface MyCycleView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MyCycleView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)images{
    self = [super initWithFrame:frame];
    if (self) {
        self.cycleTime = DefaultCycleTime;
        self.imagesArr = images;
        [self configScrollView];
        [self configPageControl];
        [self resetTimer];
    }
    return self;
}

- (void)configPageControl{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 200, CGRectGetHeight(self.frame) - 40, 180, 30)];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.imagesArr.count;
    [self addSubview:self.pageControl];
}

- (void)configScrollView{
    if (!self.scollView) {
        self.scollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*3, CGRectGetHeight(self.frame));
        [self.scollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), CGRectGetMinY(self.frame))];
        self.scollView.delegate = self;
        self.scollView.pagingEnabled = YES;
        self.scollView.showsVerticalScrollIndicator = NO;
    }
    [self addSubview:self.scollView];
    [self configImageView];
}

- (void)configImageView{
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)*2, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.scollView addSubview:self.leftImageView];
    [self.scollView addSubview:self.middleImageView];
    [self.scollView addSubview:self.rightImageView];

    self.leftImageView.image = self.imagesArr[(self.currentIndex-1 + self.imagesArr.count)%self.imagesArr.count];
    self.middleImageView.image = self.imagesArr[(self.currentIndex + self.imagesArr.count)%self.imagesArr.count];
    self.rightImageView.image = self.imagesArr[(self.currentIndex+1 + self.imagesArr.count)%self.imagesArr.count];
}

- (void)resetTimer{
    [self invalidateTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.cycleTime target:self selector:@selector(autoCycle) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)invalidateTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)autoCycle{
    self.currentIndex = (_currentIndex + 1 + self.imagesArr.count)%self.imagesArr.count;
    NSLog(@"currentIndex %ld",(long)self.currentIndex);
    self.pageControl.currentPage = self.currentIndex;
    [self changeImageWithIndex:self.currentIndex];
    self.scollView.contentOffset = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}

- (void)changeImageWithIndex:(NSInteger)index{
    self.leftImageView.image = self.imagesArr[(index-1 + self.imagesArr.count)%self.imagesArr.count];
    self.middleImageView.image = self.imagesArr[(index + self.imagesArr.count)%self.imagesArr.count];
    self.rightImageView.image = self.imagesArr[(index+1 + self.imagesArr.count)%self.imagesArr.count];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self resetTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = [self.scollView contentOffset];
    if (offset.x == 2*_scollView.frame.size.width) {
        self.currentIndex = (self.currentIndex + 1+_imagesArr.count)%self.imagesArr.count;
    } else if (offset.x == 0){
        self.currentIndex = (self.currentIndex - 1+_imagesArr.count)%self.imagesArr.count;
    }else{
        return;
    }
    
    self.pageControl.currentPage = self.currentIndex;
    [self changeImageWithIndex:self.currentIndex];
    self.scollView.contentOffset = CGPointMake(_scollView.frame.size.width, _scollView.frame.origin.y);
}


#pragma mark - Setter
- (void)setCycleTime:(NSTimeInterval)cycleTime{
    _cycleTime = cycleTime;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
