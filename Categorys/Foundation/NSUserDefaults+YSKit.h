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

+ (BOOL)synchronize;

+ (void)setBool:(BOOL)value forKey:(NSString *)key;
+ (void)setDouble:(double)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setLong:(long)value forKey:(NSString *)key;
+ (void)setLongLong:(long long)value forKey:(NSString *)key;
+ (void)setNilValueForKey:(NSString *)key;
+ (void)setObject:(id)value forKey:(NSString *)key;
+ (void)setURL:(NSURL *)url forKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;
+ (double)doubleForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (long)longForKey:(NSString *)key;
+ (long long)longLongForKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (NSURL *)URLForKey:(NSString *)key;

+ (void)setCGRect:(CGRect)rect forKey:(NSString *)key;
+ (void)setCGSize:(CGSize)size forKey:(NSString *)key;
+ (void)setCGPoint:(CGPoint)point forKey:(NSString *)key;
+ (void)setNSRange:(NSRange)range forKey:(NSString *)key;

+ (CGRect)rectForKey:(NSString *)key;
+ (CGSize)sizeForKey:(NSString *)key;
+ (CGPoint)pointForKey:(NSString *)key;
+ (NSRange)rangeForKey:(NSString *)key;

@end
