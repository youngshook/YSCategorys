/*!
    NSArray extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSArray (YSKit)

/**
 *	Returns the object located at the specified index. If index is beyond the end of the array, nil will be returned.
 *
 *	@param index An index within the bounds of the array.
 *
 *	@return The object located at index.
 */
- (id)ys_objectAtIndex:(NSUInteger)index;


/**
 *	Convert NSArray to NSString Obj
 *
 *	@return NSString Obj
 */
- (NSString *)ys_JSONString;


/**
   Creates and returns an array found in a file specified by a given URL.

   @param URL An `NSURL`. The file identified by URL must contain a string representation of a property list whose root object is an array.
   @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
   @return A new array that contains the array at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a array.
 */
+ (NSArray *)ys_arrayWithContentsOfURL:(NSURL *)URL error:(NSError **)error;


/**
   Creates and returns an array found in a file specified by a given path.

   @param path A full or relative pathname. The file identified by path must contain a string representation of a property list whose root object is a dictionary.
   @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
   @return A new dictionary that contains the dictionary at path, or `nil` if there is a file error or if the contents of the file are an invalid representation of a dictionary.
 */
+ (NSArray *)ys_arrayWithContentsOfFile:(NSString *)path error:(NSError **)error;


/**
   Creates and returns an array encoded in the given blob of data.

   @param data The data object identified by data must contain a string representation of a property list whose root object is an array.
   @param error If an error occurs, upon returns contains an NSError object that describes the problem. If you are not interested in possible errors, pass in `NULL`.
   @return A new array that contains the decoded array, or `nil` if there is an error or if the contents of the file are an invalid representation of an array.
 */
+ (NSArray *)ys_arrayWithContentsOfData:(NSData *)data error:(NSError **)error;

@end

@interface NSMutableArray (YSKit)

/** Filter a given dictionary with specified keys and adds these objects to the end of the receiving array’s content.

   @param sourceDictionary The dictionary from which to add entries
   @param firstKey ... Keys specifying which object will be added to the reciver.
 */
- (void)ys_addObjectsFromDictionary:(NSDictionary *)sourceDictionary withSpecifiedKeys:(NSString *)firstKey, ...NS_REQUIRES_NIL_TERMINATION;
@end
