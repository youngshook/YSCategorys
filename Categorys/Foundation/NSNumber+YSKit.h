//
//  NSNumber+YSKit.h
//  YSCategorys
//
//  Created by YoungShook on 14-7-9.
//  Copyright (c) 2014年 YShook Station. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (YSKit)

/**
 *  get a random integer between 0 and maxInt -1
 *
 *  @param maxInt max int value to bound a random value.
 *
 *  @return random int value
 */
+ (int) randomInt:(int)maxInt;

/**
 *  get a random BOOL value, YES or NO.
 *
 *  @return random BOOL value
 */
+ (BOOL) randomBool;

/**
 *  return a NSDate value base on unix time in seconds
 *
 *  @return a NSDate value
 */
- (NSDate *) dateValue;

@end
