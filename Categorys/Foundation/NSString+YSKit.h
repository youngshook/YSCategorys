/*!
    NSString extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

//! via: http://koolistov.net/blog/2012/02/26/nil-null-empty-macros/

#define NILIFNULL(foo) ((foo == [NSNull null]) ? nil : foo)

#define NULLIFNIL(foo) ((foo == nil) ? [NSNull null] : foo)

#define EMPTYIFNIL(foo) ((foo == nil) ? @"" : foo)

#pragma mark - -=C function=-

/**
 *  get bool string
 *
 *  @param boolValue bool value
 *
 *  @return bool string, @"YES" or @"NO"
 */
FOUNDATION_EXPORT NSString *YSNSStringFromBOOL(BOOL boolValue);

/**
 *    YSNSStringIsBlank(nil)          == YES
 *    YSNSStringIsBlank(@"")          == YES
 *    YSNSStringIsBlank(@" ")         == YES
 *    YSNSStringIsBlank(@"bob")       == NO
 *    YSNSStringIsBlank(@"  bob   ")  == NO
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
FOUNDATION_EXPORT BOOL YSNSStringIsBlank(NSString *stringValue);

/**
 *    YSNSStringIsBlankString(nil)          isEqualToString:@"YES"
 *    YSNSStringIsBlankString(@"")          isEqualToString:@"YES"
 *    YSNSStringIsBlankString(@" ")         isEqualToString:@"YES"
 *    YSNSStringIsBlankString(@"bob")       isEqualToString:@"NO"
 *    YSNSStringIsBlankString(@"  bob   ")  isEqualToString:@"NO"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
FOUNDATION_EXPORT NSString *YSNSStringIsBlankString(NSString *stringValue);

/**
 *    YSNSStringIsNotBlank(nil)           == NO
 *    YSNSStringIsNotBlank(@"")           == NO
 *    YSNSStringIsNotBlank(@" ")          == NO
 *    YSNSStringIsNotBlank(@"bob")        == YES
 *    YSNSStringIsNotBlank(@"  bob   ")   == YES
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
FOUNDATION_EXPORT BOOL YSNSStringIsNotBlank(NSString *stringValue);

/**
 *    YSNSStringIsNotBlankString(nil)           isEqualToString:@"NO"
 *    YSNSStringIsNotBlankString(@"")           isEqualToString:@"NO"
 *    YSNSStringIsNotBlankString(@" ")          isEqualToString:@"NO"
 *    YSNSStringIsNotBlankString(@"bob")        isEqualToString:@"YES"
 *    YSNSStringIsNotBlankString(@"  bob   ")   isEqualToString:@"YES"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
FOUNDATION_EXPORT NSString *YSNSStringIsNotBlankString(NSString *stringValue);

/**
 *    YSNSStringIsEmpty(nil)          == YES
 *    YSNSStringIsEmpty(@"")          == YES
 *    YSNSStringIsEmpty(@" ")         == NO
 *    YSNSStringIsEmpty(@"bob")       == NO
 *    YSNSStringIsEmpty(@"  bob   ")  == NO
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
FOUNDATION_EXPORT BOOL YSNSStringIsEmpty(NSString *stringValue);

/**
 *    YSNSStringIsEmptyString(nil)          isEqualToString:@"YES"
 *    YSNSStringIsEmptyString(@"")          isEqualToString:@"YES"
 *    YSNSStringIsEmptyString(@" ")         isEqualToString:@"NO"
 *    YSNSStringIsEmptyString(@"bob")       isEqualToString:@"NO"
 *    YSNSStringIsEmptyString(@"  bob   ")  isEqualToString:@"NO"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
FOUNDATION_EXPORT NSString *YSNSStringIsEmptyString(NSString *stringValue);

/**
 *    YSNSStringIsNotEmpty(nil)           == NO
 *    YSNSStringIsNotEmpty(@"")           == NO
 *    YSNSStringIsNotEmpty(@" ")          == YES
 *    YSNSStringIsNotEmpty(@"bob")        == YES
 *    YSNSStringIsNotEmpty(@"  bob   ")   == YES
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
FOUNDATION_EXPORT BOOL YSNSStringIsNotEmpty(NSString *stringValue);

/**
 *    YSNSStringIsNotEmptyString(nil)           isEqualToString:@"NO"
 *    YSNSStringIsNotEmptyString(@"")           isEqualToString:@"NO"
 *    YSNSStringIsNotEmptyString(@" ")          isEqualToString:@"YES"
 *    YSNSStringIsNotEmptyString(@"bob")        isEqualToString:@"YES"
 *    YSNSStringIsNotEmptyString(@"  bob   ")   isEqualToString:@"YES"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
FOUNDATION_EXPORT NSString *YSNSStringIsNotEmptyString(NSString *stringValue);


#pragma mark - -=Objective-C function=-

@interface NSString (YSKit)

+ (NSString *)ys_MD5String:(NSString *)string;

+ (NSString *)ys_pinyinFromString:(NSString *)orgString;

/** Returns a Boolean value indicating whether the receiver contains the specified string.

   @param string The string to check. This value must not be `nil`.

   @return `YES` if the receiver contains the string; otherwise, `NO`.
 */
- (BOOL)ys_containsString:(NSString *)string;

/** Returns a Boolean value indicating whether the receiver contains the specified string.

   @param string The string to check. This value must not be `nil`.
   @param mask A mask specifying search options. The following options may be specified by combining them with the C bitwise OR operator: NSCaseInsensitiveSearch, NSLiteralSearch, NSBackwardsSearch, NSAnchoredSearch. See String Programming Guide for details on these options.

   @return `YES` if the receiver contains the string; otherwise, `NO`.
 */
- (BOOL)ys_containsString:(NSString *)string options:(NSStringCompareOptions)mask;

/** Reverse a NSString

   @return String reversed
 */
- (NSString *)ys_stringTrimToWidthLength:(CGFloat)length WithFont:(UIFont *)font DEPRECATED_ATTRIBUTE;

/** Remove HTML tags in receiver’s.
 */
- (NSString *)ys_extractedHTMLContent;

- (id)ys_JSONValue;
- (BOOL)ys_isInteger;
- (NSArray *)ys_componentsSeparatedAtEachCharacter;

- (NSInteger)ys_numberOfOccurrencesOfString:(NSString *)string;
- (NSString *)ys_stringByRemovingCharactersInSet:(NSCharacterSet *)set;
- (NSString *)ys_firstLetterCapitalizedString;
- (NSString *)ys_stringRepeated:(NSUInteger)repeatCount;
- (NSString *)ys_normalizedString;
- (NSString *)ys_reverseString;

- (NSString *)ys_URLEncodedString;
- (NSString *)ys_URLDecodedString;
- (NSDictionary *)ys_parametersFromURLString;

- (NSString *)ys_substringFromString:(NSString *)string;
- (NSString *)ys_substringToString:(NSString *)string;
- (NSString *)ys_substringBetweenString:(NSString *)startString andString:(NSString *)endString;

- (NSString *)ys_substringFromString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd;
- (NSString *)ys_substringToString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd;
- (NSString *)ys_substringBetweenString:(NSString *)startString andString:(NSString *)endString searchFromEnd:(BOOL)searchFromEnd;

#pragma mark - Blank

/**
 *    [NSString ys_isBlank:nil]          == YES
 *    [NSString ys_isBlank:@""]          == YES
 *    [NSString ys_isBlank:@" "]         == YES
 *    [NSString ys_isBlank:@"bob"]       == NO
 *    [NSString ys_isBlank:@"  bob   "]  == NO
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
+ (BOOL)ys_isBlank:(NSString *)stringValue;

/**
 *    [NSString ys_isBlankString:nil]          isEqualToString:@"YES"
 *    [NSString ys_isBlankString:@""]          isEqualToString:@"YES"
 *    [NSString ys_isBlankString:@" "]         isEqualToString:@"YES"
 *    [NSString ys_isBlankString:@"bob"]       isEqualToString:@"NO"
 *    [NSString ys_isBlankString:@"  bob   "]  isEqualToString:@"NO"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
+ (NSString *)ys_isBlankString:(NSString *)stringValue;

/**
 *    [NSString ys_isNotBlank:nil]          == NO
 *    [NSString ys_isNotBlank:@""]          == NO
 *    [NSString ys_isNotBlank:@" "]         == NO
 *    [NSString ys_isNotBlank:@"bob"]       == YES
 *    [NSString ys_isNotBlank:@"  bob   "]  == YES
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
+ (BOOL)ys_isNotBlank:(NSString *)stringValue;

/**
 *    [NSString ys_isNotBlankString:nil]          isEqualToString:@"NO"
 *    [NSString ys_isNotBlankString:@""]          isEqualToString:@"NO"
 *    [NSString ys_isNotBlankString:@" "]         isEqualToString:@"NO"
 *    [NSString ys_isNotBlankString:@"bob"]       isEqualToString:@"YES"
 *    [NSString ys_isNotBlankString:@"  bob   "]  isEqualToString:@"YES"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
+ (NSString *)ys_isNotBlankString:(NSString *)stringValue;

/**
 *    [NSString ys_isEmpty:nil]          == YES
 *    [NSString ys_isEmpty:@""]          == YES
 *    [NSString ys_isEmpty:@" "]         == NO
 *    [NSString ys_isEmpty:@"bob"]       == NO
 *    [NSString ys_isEmpty:@"  bob   "]  == NO
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
+ (BOOL)ys_isEmpty:(NSString *)stringValue;

/**
 *    [NSString ys_isEmptyString:nil]          isEqualToString:@"YES"
 *    [NSString ys_isEmptyString:@""]          isEqualToString:@"YES"
 *    [NSString ys_isEmptyString:@" "]         isEqualToString:@"NO"
 *    [NSString ys_isEmptyString:@"bob"]       isEqualToString:@"NO"
 *    [NSString ys_isEmptyString:@"  bob   "]  isEqualToString:@"NO"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
+ (NSString *)ys_isEmptyString:(NSString *)stringValue;

/**
 *    [NSString ys_isNotEmpty:nil]          == NO
 *    [NSString ys_isNotEmpty:@""]          == NO
 *    [NSString ys_isNotEmpty:@" "]         == YES
 *    [NSString ys_isNotEmpty:@"bob"]       == YES
 *    [NSString ys_isNotEmpty:@"  bob   "]  == YES
 *
 *  @param stringValue tested string
 *
 *  @return BOOL YES or NO
 */
+ (BOOL)ys_isNotEmpty:(NSString *)stringValue;

/**
 *    [NSString ys_isNotEmptyString:nil]          isEqualToString:@"NO"
 *    [NSString ys_isNotEmptyString:@""]          isEqualToString:@"NO"
 *    [NSString ys_isNotEmptyString:@" "]         isEqualToString:@"YES"
 *    [NSString ys_isNotEmptyString:@"bob"]       isEqualToString:@"YES"
 *    [NSString ys_isNotEmptyString:@"  bob   "]  isEqualToString:@"YES"
 *
 *  @param stringValue tested string
 *
 *  @return NSString @"YES" or @"NO"
 */
+ (NSString *)ys_isNotEmptyString:(NSString *)stringValue;

@end
