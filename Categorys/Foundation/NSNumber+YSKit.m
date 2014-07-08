//
//  NSNumber+YSKit.m
//  YSCategorys
//
//  Created by YoungShook on 14-7-9.
//  Copyright (c) 2014年 YShook Station. All rights reserved.
//

#import "NSNumber+YSKit.h"

@implementation NSNumber (YSKit)

+ (int) randomInt:(int)maxInt
{
    int r = arc4random() % maxInt;
	
    return r;
}

+ (BOOL) randomBool
{
    return [NSNumber randomInt:2] != 0 ? YES : NO;
}

- (NSDate *) dateValue
{
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];      // if self is nil, its doubleValue is 0.0
}

@end
