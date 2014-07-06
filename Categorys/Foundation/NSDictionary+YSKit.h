/*!
    NSDictionary extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSDictionary (YSKit)

- (BOOL)boolForKey:(NSString *)keyName;
- (float)floatForKey:(NSString *)keyName;
- (NSInteger)integerForKey:(NSString *)keyName;
- (double)doubleForKey:(NSString *)keyName;

@end

@interface NSMutableDictionary (YSKit)

/** Adds to the receiving dictionary the entries from another dictionary with specified keys.

 @param sourceDictionary The dictionary from which to add entries.
 @param firstKey ... Keys specifying which entry will be added to the reciver.
 */
- (NSUInteger)addEntriesFromDictionary:(NSDictionary *)sourceDictionary withSpecifiedKeys:(NSString *)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

- (void)setBool:(BOOL)value forKey:(NSString *)keyName;
- (void)setFloat:(float)value forKey:(NSString *)keyName;
- (void)setInteger:(NSInteger)value forKey:(NSString *)keyName;
- (void)setDouble:(double)value forKey:(NSString *)keyName;

@end
