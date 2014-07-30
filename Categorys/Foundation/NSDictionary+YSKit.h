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

- (BOOL)ys_boolForKey:(NSString *)keyName;
- (float)ys_floatForKey:(NSString *)keyName;
- (NSInteger)ys_integerForKey:(NSString *)keyName;
- (double)ys_doubleForKey:(NSString *)keyName;

- (NSString *)ys_JSONString;

+ (NSDictionary *)ys_dictionaryWithJSON:(NSString *)json;

/**
   Creates and returns a dictionary using the keys and values found in a file specified by a given URL.

   @param URL An URL. The file identified by URL must contain a string representation of a property list whose root object is a dictionary.
   @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
   @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSDictionary *)ys_dictionaryWithContentsOfURL:(NSURL *)URL error:(NSError **)error;

/**
   Creates and returns a dictionary using the keys and values found in a file specified by a given path.

   @param path A full or relative pathname. The file identified by path must contain a string representation of a property list whose root object is a dictionary.
   @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
   @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSDictionary *)ys_dictionaryWithContentsOfFile:(NSString *)path error:(NSError **)error;

/**
   Creates and returns a dictionary using the keys and values found in the given data.

   @param data The data object identified by data must contain a string representation of a property list whose root object is a dictionary.
   @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
   @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSDictionary *)ys_dictionaryWithContentsOfData:(NSData *)data error:(NSError **)error;

@end

@interface NSMutableDictionary (YSKit)

/** Adds to the receiving dictionary the entries from another dictionary with specified keys.

   @param sourceDictionary The dictionary from which to add entries.
   @param firstKey ... Keys specifying which entry will be added to the reciver.
 */
- (NSUInteger)ys_addEntriesFromDictionary:(NSDictionary *)sourceDictionary withSpecifiedKeys:(NSString *)firstKey, ...NS_REQUIRES_NIL_TERMINATION;

- (void)ys_setBool:(BOOL)value forKey:(NSString *)keyName;
- (void)ys_setFloat:(float)value forKey:(NSString *)keyName;
- (void)ys_setInteger:(NSInteger)value forKey:(NSString *)keyName;
- (void)ys_setDouble:(double)value forKey:(NSString *)keyName;

@end
