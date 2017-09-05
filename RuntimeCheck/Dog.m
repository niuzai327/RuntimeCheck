//
//  Dog.m
//  RuntimeCheck
//
//  Created by YXY on 2017/8/21.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "Dog.h"
#import "Cat.h"

@implementation Dog

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"jump"]) {
        return [[Cat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}


@end
