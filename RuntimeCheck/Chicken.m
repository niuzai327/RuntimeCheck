//
//  Chicken.m
//  RuntimeCheck
//
//  Created by YXY on 2017/8/21.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import "Chicken.h"
#import "Cat.h"

@implementation Chicken

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"jump"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    [anInvocation invokeWithTarget:[[Cat alloc] init]];
    anInvocation.selector = @selector(fly);
    [anInvocation invokeWithTarget:self];
}

- (void)fly{
    NSLog(@"%@ fly",self);
}

@end
