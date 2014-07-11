
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

- (BOOL)isInteger
{
	return [self rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

- (NSArray *)componentsSeparatedAtEachCharacter
{
	NSUInteger length		= [self length];
	NSMutableArray* array	= [NSMutableArray arrayWithCapacity:length];
	
	[self enumerateSubstringsInRange:NSMakeRange(0, length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		
		[array addObject:substring];
	}];
	
	return [NSArray arrayWithArray:array];
}

- (NSInteger)numberOfOccurrencesOfString:(NSString *)string
{
	NSInteger fullLength	= [self length];
	NSInteger removedLength = [[self stringByReplacingOccurrencesOfString:string withString:@""] length];
	
	return (fullLength - removedLength) / [string length];
}

- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)set
{
	NSUInteger length		= [self length];
	NSMutableString* string	= [NSMutableString stringWithCapacity:length];
	
	for (int i = 0; i < length; i++) {
		
		unichar c = [self characterAtIndex:i];
		
		if (![set characterIsMember:c])
			[string appendFormat:@"%C", c];
	}
	
	return [NSString stringWithString:string];
}


- (NSString *)firstLetterCapitalizedString
{
	if ([self length] < 2)
		return [self uppercaseString];
	
	NSString* first = [self substringToIndex:1];
	NSString* rest	= [self substringFromIndex:1];
	
	return [NSString stringWithFormat:@"%@%@", [first uppercaseString], rest];
}

- (NSString *)stringRepeated:(NSUInteger)repeatCount
{
	if (!repeatCount)
		return nil;
	
	if (repeatCount == 1)
		return self;
	
	NSMutableString* repeatedString = [NSMutableString string];
	
	for (NSUInteger i = 0; i < repeatCount; i++)
		[repeatedString appendString:self];
	
	return [NSString stringWithString:repeatedString];
}

- (NSString *)normalizedString
{
	return [[self decomposedStringWithCanonicalMapping] lowercaseString];
}

- (NSString *)reverseString {
	NSMutableString *reversedStr;
	NSUInteger len = self.length;

	reversedStr = [NSMutableString stringWithCapacity:len];
	
	while (len > 0)
		[reversedStr appendString: [NSString stringWithFormat:@"%C", [self characterAtIndex:--len]]];
	
	return reversedStr;
}

- (NSString *)URLEncodedString
{
	return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,  (__bridge CFStringRef)self,  NULL,  (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

- (NSString *)URLDecodedString
{
	return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding
	(NULL, (__bridge CFStringRef)self, NULL, kCFStringEncodingUTF8);
}

- (NSDictionary *)parametersFromURLString
{
	NSArray* pairs				= [self componentsSeparatedByString:@"&"];
	NSMutableDictionary* params	= [NSMutableDictionary dictionary];
	
	for (NSString* pair in pairs) {
		
		NSArray* item	= [pair componentsSeparatedByString:@"="];
		NSString* key	= [item count] > 0 ? item[0] : nil;
		NSString* value	= [item count] > 1 ? item[1] : nil;
		
		if ([key length] && [value length])
			[params setObject:[value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:key];
	}
	
	return [NSDictionary dictionaryWithDictionary:params];
}

- (NSString *)substringFromString:(NSString *)string
{
	return [self substringFromString:string searchFromEnd:NO];
}

- (NSString *)substringToString:(NSString *)string
{
	return [self substringToString:string searchFromEnd:NO];
}

- (NSString *)substringBetweenString:(NSString *)startString andString:(NSString *)endString
{
	return [self substringBetweenString:startString andString:endString searchFromEnd:NO];
}

- (NSString *)substringFromString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd
{
	return [self substringBetweenString:string andString:@"" searchFromEnd:searchFromEnd];
}

- (NSString *)substringToString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd
{
	return [self substringBetweenString:@"" andString:string searchFromEnd:searchFromEnd];
}

- (NSString *)substringBetweenString:(NSString *)startString andString:(NSString *)endString searchFromEnd:(BOOL)searchFromEnd
{
	NSUInteger len = [self length];
	
	if (!len)
		return self;
	
	NSStringCompareOptions options	= searchFromEnd ? NSBackwardsSearch : 0;
	NSRange start					= [self rangeOfString:startString options:options];
	
	if (!start.length)
		start = NSMakeRange(0, 0);
	
	NSUInteger startEnd	= start.location + start.length;
	NSRange end			= [self rangeOfString:endString options:options range:NSMakeRange(startEnd, len-startEnd)];
	
	if (!end.length)
		end = NSMakeRange(len, 0);
	
	NSRange range = NSMakeRange(startEnd, end.location-startEnd);
	
	return [self substringWithRange:range];
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





