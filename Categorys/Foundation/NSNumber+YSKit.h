/*!
    NSNumber extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSNumber (YSKit)

/**
 *  get a random integer between 0 and maxInt -1
 *
 *  @param maxInt max int value to bound a random value.
 *
 *  @return random int value
 */
+ (int)ys_randomInt:(int)maxInt;

/**
 *  get a random BOOL value, YES or NO.
 *
 *  @return random BOOL value
 */
+ (BOOL)ys_randomBool;

/**
 *  return a NSDate value base on unix time in seconds
 *
 *  @return a NSDate value
 */
- (NSDate *)ys_dateValue;

@end
