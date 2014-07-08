
#import "YSKit.h"
#import "NSString+YSKit.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (YSKit)

//! via: http://lldong.github.io/2012/11/06/hanzi-to-pinyin/
+ (NSString *)pinyinFromString:(NSString *)orgString {
    NSMutableString *string = [orgString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripDiacritics, NO);
    return string;
}

- (BOOL)containsString:(NSString *)string {
    return ([self rangeOfString:string].location != NSNotFound);
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)mask {
    return ([self rangeOfString:string options:mask].location != NSNotFound);
}

- (NSString *)reverseString {
	NSMutableString *reversedStr;
	NSUInteger len = self.length;

	// Auto released string
	reversedStr = [NSMutableString stringWithCapacity:len];

	// Probably woefully inefficient...
	while (len > 0)
		[reversedStr appendString: [NSString stringWithFormat:@"%C", [self characterAtIndex:--len]]];

	return reversedStr;
}

- (NSString *)stringTrimToWidthLength:(CGFloat)length WithFont:(UIFont *)font {
	NSString * tmp = self;
	CGFloat ctLength;
	NSUInteger charNumToRemove;
	CGFloat aLetterWidthSafe = [@"汉" sizeWithFont:font].width*1.5;
	bool trimed = false;

	while ((ctLength = [tmp sizeWithFont:font].width) > length) {
		charNumToRemove = (ctLength-length)/aLetterWidthSafe;
		if (charNumToRemove == 0) {
			charNumToRemove = 1;
		}
		tmp = [tmp substringToIndex:([tmp length] - charNumToRemove)];
		trimed = true;
	}

	return trimed ? [NSString stringWithFormat:@"%@...", tmp] : [self copy];
}

//! via: http://stackoverflow.com/questions/1524604/md5-algorithm-in-objective-c
+ (NSString *)MD5String:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];

}

- (NSString *)extractedHTMLContent {
    NSError __autoreleasing *e = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(?:\"[^\"]*\"['\"]*|'[^']*'['\"]*|[^'\">])+>" options:NSRegularExpressionDotMatchesLineSeparators error:&e];
    if (e) NSLog(@"%@", e);
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

#pragma mark - Blank

+ (BOOL) isBlank:(NSString *)stringValue
{
    return NSStringIsBlank(stringValue);
}

+ (NSString *) isBlankString:(NSString *)stringValue
{
    return NSStringIsBlankString(stringValue);
}

+ (BOOL) isNotBlank:(NSString *)stringValue
{
    return NSStringIsNotBlank(stringValue);
}

+ (NSString *) isNotBlankString:(NSString *)stringValue
{
    return NSStringIsNotBlankString(stringValue);
}

+ (BOOL) isEmpty:(NSString *)stringValue
{
    return NSStringIsEmpty(stringValue);
}

+ (NSString *) isEmptyString:(NSString *)stringValue
{
    return NSStringIsEmptyString(stringValue);
}

+ (BOOL) isNotEmpty:(NSString *)stringValue
{
    return NSStringIsNotEmpty(stringValue);
}

+ (NSString *) isNotEmptyString:(NSString *)stringValue
{
    return NSStringIsNotEmptyString(stringValue);
}

@end

#pragma mark - Blank C function

NSString* NSStringFromBOOL(BOOL boolValue)
{
    return boolValue == YES ? @"YES" : @"NO";
}

BOOL NSStringIsBlank(NSString *stringValue)
{
    BOOL blank = NO;
	
    if (stringValue.length == 0) {
		
        blank = YES;
		
    } else if ([stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
		
        blank = YES;
    }
	
    return blank;
}

NSString* NSStringIsBlankString(NSString *stringValue)
{
    return NSStringFromBOOL(NSStringIsBlank(stringValue));
}

BOOL NSStringIsNotBlank(NSString *stringValue)
{
    return !NSStringIsBlank(stringValue);
}

NSString* NSStringIsNotBlankString(NSString *stringValue)
{
    return NSStringFromBOOL(NSStringIsNotBlank(stringValue));
}

BOOL NSStringIsEmpty(NSString *stringValue)
{
    BOOL empty = NO;
	
    if (stringValue.length == 0) {
		
        empty = YES;
    }
	
    return empty;
}

NSString* NSStringIsEmptyString(NSString *stringValue)
{
    return NSStringFromBOOL(NSStringIsEmpty(stringValue));
}

BOOL NSStringIsNotEmpty(NSString *stringValue)
{
    return !(NSStringIsEmpty(stringValue));
}

NSString* NSStringIsNotEmptyString(NSString *stringValue)
{
    return NSStringFromBOOL(NSStringIsNotEmpty(stringValue));
}





