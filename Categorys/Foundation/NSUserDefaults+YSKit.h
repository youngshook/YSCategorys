/*!
    NSUserDefaults extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSUserDefaults (YSKit)

+ (BOOL)ys_synchronize;

+ (void)ys_setBool:(BOOL)value forKey:(NSString *)key;
+ (void)ys_setDouble:(double)value forKey:(NSString *)key;
+ (void)ys_setFloat:(float)value forKey:(NSString *)key;
+ (void)ys_setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)ys_setLong:(long)value forKey:(NSString *)key;
+ (void)ys_setLongLong:(long long)value forKey:(NSString *)key;
+ (void)ys_setNilValueForKey:(NSString *)key;
+ (void)ys_setObject:(id)value forKey:(NSString *)key;
+ (void)ys_setURL:(NSURL *)url forKey:(NSString *)key;

+ (BOOL)ys_boolForKey:(NSString *)key;
+ (double)ys_doubleForKey:(NSString *)key;
+ (float)ys_floatForKey:(NSString *)key;
+ (NSInteger)ys_integerForKey:(NSString *)key;
+ (long)ys_longForKey:(NSString *)key;
+ (long long)ys_longLongForKey:(NSString *)key;
+ (id)ys_objectForKey:(NSString *)key;
+ (NSURL *)ys_URLForKey:(NSString *)key;

+ (void)ys_setCGRect:(CGRect)rect forKey:(NSString *)key;
+ (void)ys_setCGSize:(CGSize)size forKey:(NSString *)key;
+ (void)ys_setCGPoint:(CGPoint)point forKey:(NSString *)key;
+ (void)ys_setNSRange:(NSRange)range forKey:(NSString *)key;

+ (CGRect)ys_rectForKey:(NSString *)key;
+ (CGSize)ys_sizeForKey:(NSString *)key;
+ (CGPoint)ys_pointForKey:(NSString *)key;
+ (NSRange)ys_rangeForKey:(NSString *)key;

@end
