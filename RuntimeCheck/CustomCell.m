//
//  CustomCell.m
//  RuntimeCheck
//
//  Created by YXY on 2017/9/6.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) UIView *separatorLine;

@end

@implementation CustomCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.textLabel = label;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        self.separatorLine = line;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.separatorLine.frame = CGRectMake(0, self.frame.size.height - .5, self.frame.size.width, .5);
    self.textLabel.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 20);
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.textLabel.text = text;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
