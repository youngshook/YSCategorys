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

- (NSString*)jsonString;

+ (NSDictionary*)dictionaryWithJSON:(NSString*)json;

/**
 Creates and returns a dictionary using the keys and values found in a file specified by a given URL.
 
 @param URL An URL. The file identified by URL must contain a string representation of a property list whose root object is a dictionary.
 @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
 @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSDictionary *)dictionaryWithContentsOfURL:(NSURL *)URL error:(NSError **)error;

/**
 Creates and returns a dictionary using the keys and values found in a file specified by a given path.
 
 @param path A full or relative pathname. The file identified by path must contain a string representation of a property list whose root object is a dictionary.
 @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
 @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSDictionary *)dictionaryWithContentsOfFile:(NSString *)path error:(NSError **)error;

/**
 Creates and returns a dictionary using the keys and values found in the given data.
 
 @param data The data object identified by data must contain a string representation of a property list whose root object is a dictionary.
 @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
 @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data error:(NSError **)error;

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
