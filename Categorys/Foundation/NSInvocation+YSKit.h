/*!
    NSInvocation extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSInvocation (YSKit)

+ (NSInvocation *)ys_invocationWithTarget:(id)target andSelector:(SEL)selector;
+ (NSInvocation *)ys_invocationWithTarget:(id)target selector:(SEL)selector andArguments:(NSArray *)arguments;


@end
