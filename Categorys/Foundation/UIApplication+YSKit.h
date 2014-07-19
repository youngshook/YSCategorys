/*!
    UIApplication extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>

@interface UIApplication (YSKit)

- (CGFloat)ys_applicationVersion;

- (void)ys_increaseNetworkActivityCounter;
- (void)ys_decreaseNetworkActivityCounter;

@end
