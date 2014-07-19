#import "NSString+YSKit.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (YSKit)

//! via: http://lldong.github.io/2012/11/06/hanzi-to-pinyin/
+ (NSString *)ys_pinyinFromString:(NSString *)orgString {
	NSMutableString *string = [orgString mutableCopy];
	CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformMandarinLatin, NO);
	CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripDiacritics, NO);
	return string;
}

- (BOOL)ys_containsString:(NSString *)string {
	return ([self rangeOfString:string].location != NSNotFound);
}

- (BOOL)ys_containsString:(NSString *)string options:(NSStringCompareOptions)mask {
	return ([self rangeOfString:string options:mask].location != NSNotFound);
}

- (NSString *)ys_stringTrimToWidthLength:(CGFloat)length WithFont:(UIFont *)font {
	NSString *tmp = self;
	CGFloat ctLength;
	NSUInteger charNumToRemove;
	CGFloat aLetterWidthSafe = [@"汉" sizeWithFont : font].width * 1.5;
	bool trimed = false;

	while ((ctLength = [tmp sizeWithFont:font].width) > length) {
		charNumToRemove = (ctLength - length) / aLetterWidthSafe;
		if (charNumToRemove == 0) {
			charNumToRemove = 1;
		}
		tmp = [tmp substringToIndex:([tmp length] - charNumToRemove)];
		trimed = true;
	}

	return trimed ? [NSString stringWithFormat:@"%@...", tmp] : [self copy];
}

//! via: http://stackoverflow.com/questions/1524604/md5-algorithm-in-objective-c
+ (NSString *)ys_MD5String:(NSString *)string {
	const char *cStr = [string UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)ys_extractedHTMLContent {
	NSError __autoreleasing *e = nil;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(?:\"[^\"]*\"['\"]*|'[^']*'['\"]*|[^'\">])+>" options:NSRegularExpressionDotMatchesLineSeparators error:&e];
	if (e) NSLog(@"%@", e);
	return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
}

- (id)ys_JSONValue {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	__autoreleasing NSError *error = nil;
	id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
	if (error != nil) return nil;
	return result;
}

- (BOOL)ys_isInteger {
	return [self rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

- (NSArray *)ys_componentsSeparatedAtEachCharacter {
	NSUInteger length       = [self length];
	NSMutableArray *array   = [NSMutableArray arrayWithCapacity:length];

	[self enumerateSubstringsInRange:NSMakeRange(0, length) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
	    [array addObject:substring];
	}];

	return [NSArray arrayWithArray:array];
}

- (NSInteger)ys_numberOfOccurrencesOfString:(NSString *)string {
	NSInteger fullLength    = [self length];
	NSInteger removedLength = [[self stringByReplacingOccurrencesOfString:string withString:@""] length];

	return (fullLength - removedLength) / [string length];
}

- (NSString *)ys_stringByRemovingCharactersInSet:(NSCharacterSet *)set {
	NSUInteger length       = [self length];
	NSMutableString *string = [NSMutableString stringWithCapacity:length];

	for (int i = 0; i < length; i++) {
		unichar c = [self characterAtIndex:i];

		if (![set characterIsMember:c])
			[string appendFormat:@"%C", c];
	}

	return [NSString stringWithString:string];
}

- (NSString *)ys_firstLetterCapitalizedString {
	if ([self length] < 2)
		return [self uppercaseString];

	NSString *first = [self substringToIndex:1];
	NSString *rest  = [self substringFromIndex:1];

	return [NSString stringWithFormat:@"%@%@", [first uppercaseString], rest];
}

- (NSString *)ys_stringRepeated:(NSUInteger)repeatCount {
	if (!repeatCount)
		return nil;

	if (repeatCount == 1)
		return self;

	NSMutableString *repeatedString = [NSMutableString string];

	for (NSUInteger i = 0; i < repeatCount; i++)
		[repeatedString appendString:self];

	return [NSString stringWithString:repeatedString];
}

- (NSString *)ys_normalizedString {
	return [[self decomposedStringWithCanonicalMapping] lowercaseString];
}

- (NSString *)ys_reverseString {
	NSMutableString *reversedStr;
	NSUInteger len = self.length;

	reversedStr = [NSMutableString stringWithCapacity:len];

	while (len > 0)
		[reversedStr appendString:[NSString stringWithFormat:@"%C", [self characterAtIndex:--len]]];

	return reversedStr;
}

- (NSString *)ys_URLEncodedString {
	return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,  (__bridge CFStringRef)self,  NULL,  (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

- (NSString *)ys_URLDecodedString {
	return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding
	           (NULL, (__bridge CFStringRef)self, NULL, kCFStringEncodingUTF8);
}

- (NSDictionary *)ys_parametersFromURLString {
	NSArray *pairs              = [self componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = [NSMutableDictionary dictionary];

	for (NSString *pair in pairs) {
		NSArray *item   = [pair componentsSeparatedByString:@"="];
		NSString *key   = [item count] > 0 ? item[0] : nil;
		NSString *value = [item count] > 1 ? item[1] : nil;

		if ([key length] && [value length])
			[params setObject:[value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:key];
	}

	return [NSDictionary dictionaryWithDictionary:params];
}

- (NSString *)ys_substringFromString:(NSString *)string {
	return [self ys_substringFromString:string searchFromEnd:NO];
}

- (NSString *)ys_substringToString:(NSString *)string {
	return [self ys_substringToString:string searchFromEnd:NO];
}

- (NSString *)ys_substringBetweenString:(NSString *)startString andString:(NSString *)endString {
	return [self ys_substringBetweenString:startString andString:endString searchFromEnd:NO];
}

- (NSString *)ys_substringFromString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd {
	return [self ys_substringBetweenString:string andString:@"" searchFromEnd:searchFromEnd];
}

- (NSString *)ys_substringToString:(NSString *)string searchFromEnd:(BOOL)searchFromEnd {
	return [self ys_substringBetweenString:@"" andString:string searchFromEnd:searchFromEnd];
}

- (NSString *)ys_substringBetweenString:(NSString *)startString andString:(NSString *)endString searchFromEnd:(BOOL)searchFromEnd {
	NSUInteger len = [self length];

	if (!len)
		return self;

	NSStringCompareOptions options  = searchFromEnd ? NSBackwardsSearch : 0;
	NSRange start                   = [self rangeOfString:startString options:options];

	if (!start.length)
		start = NSMakeRange(0, 0);

	NSUInteger startEnd = start.location + start.length;
	NSRange end         = [self rangeOfString:endString options:options range:NSMakeRange(startEnd, len - startEnd)];

	if (!end.length)
		end = NSMakeRange(len, 0);

	NSRange range = NSMakeRange(startEnd, end.location - startEnd);

	return [self substringWithRange:range];
}

#pragma mark - Blank

+ (BOOL)ys_isBlank:(NSString *)stringValue {
	return YSNSStringIsBlank(stringValue);
}

+ (NSString *)ys_isBlankString:(NSString *)stringValue {
	return YSNSStringIsBlankString(stringValue);
}

+ (BOOL)ys_isNotBlank:(NSString *)stringValue {
	return YSNSStringIsNotBlank(stringValue);
}

+ (NSString *)ys_isNotBlankString:(NSString *)stringValue {
	return YSNSStringIsNotBlankString(stringValue);
}

+ (BOOL)ys_isEmpty:(NSString *)stringValue {
	return YSNSStringIsEmpty(stringValue);
}

+ (NSString *)ys_isEmptyString:(NSString *)stringValue {
	return YSNSStringIsEmptyString(stringValue);
}

+ (BOOL)ys_isNotEmpty:(NSString *)stringValue {
	return YSNSStringIsNotEmpty(stringValue);
}

+ (NSString *)ys_isNotEmptyString:(NSString *)stringValue {
	return YSNSStringIsNotEmptyString(stringValue);
}

@end

#pragma mark - Blank C function

NSString *YSNSStringFromBOOL(BOOL boolValue) {
	return boolValue == YES ? @"YES" : @"NO";
}

BOOL YSNSStringIsBlank(NSString *stringValue) {
	BOOL blank = NO;

	if (stringValue.length == 0) {
		blank = YES;
	}
	else if ([stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
		blank = YES;
	}

	return blank;
}

NSString *YSNSStringIsBlankString(NSString *stringValue) {
	return YSNSStringFromBOOL(YSNSStringIsBlank(stringValue));
}

BOOL YSNSStringIsNotBlank(NSString *stringValue) {
	return !YSNSStringIsBlank(stringValue);
}

NSString *YSNSStringIsNotBlankString(NSString *stringValue) {
	return YSNSStringFromBOOL(YSNSStringIsNotBlank(stringValue));
}

BOOL YSNSStringIsEmpty(NSString *stringValue) {
	BOOL empty = NO;

	if (stringValue.length == 0) {
		empty = YES;
	}

	return empty;
}

NSString *YSNSStringIsEmptyString(NSString *stringValue) {
	return YSNSStringFromBOOL(YSNSStringIsEmpty(stringValue));
}

BOOL YSNSStringIsNotEmpty(NSString *stringValue) {
	return !(YSNSStringIsEmpty(stringValue));
}

NSString *YSNSStringIsNotEmptyString(NSString *stringValue) {
	return YSNSStringFromBOOL(YSNSStringIsNotEmpty(stringValue));
}
