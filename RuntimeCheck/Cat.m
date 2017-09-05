//
//  Cat.m
//  RuntimeCheck
//
//  Created by YXY on 2017/8/21.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "Cat.h"
#import <objc/runtime.h>

void jump (id self,SEL cmd);

@interface Cat ()


@property (nonatomic, copy) NSString *name;

@end

@implementation Cat

- (instancetype)init{
    self = [super init];
    if (self) {
        self.name = @"Kitty";
    }
    return self;
}

- (void)sayHi{
    NSLog(@"%@",self.name);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:@"jump"]) {
        class_addMethod(self, sel, (IMP)jump, "v:@");
        return YES;
    }
    return [super respondsToSelector:sel];
}

void jump (id self, SEL cmd) {
    NSLog(@" %@ jump",self);
}

@end
