//
//  Cat.h
//  RuntimeCheck
//
//  Created by YXY on 2017/8/21.
//  Copyright © 2017年 NewAsia. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Cat : NSObject
{
    @private
    NSString *_sex;
    @package
    NSString *_numbers;
}

- (void)jump;

- (void)sayHi;

@end
