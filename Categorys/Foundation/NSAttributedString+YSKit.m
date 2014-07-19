#import "NSAttributedString+YSKit.h"

@implementation NSAttributedString (YSKit)

+ (instancetype)ys_hyperlinkFromString:(NSString *)inString withURL:(NSURL *)aURL {
	NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:inString];
	NSRange range = NSMakeRange(0, [attrString length]);

	[attrString beginEditing];
	[attrString addAttribute:NSLinkAttributeName value:[aURL absoluteString] range:range];

	// make the text appear in blue
	//    [attrString addAttribute:NSForegroundColorAttributeName value:RGBHex(0xFF9E2C) range:range];

	// next make the text appear with an underline
	[attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];

	[attrString endEditing];

	return attrString;
}

+ (instancetype)ys_linkifiedAttributedStringFromString:(NSString *)string {
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
	NSError *error = nil;
	NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
	if (!detector) {
		NSLog(@"data detector error: %@", error);
	}
	NSArray *matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
	for (NSTextCheckingResult *match in matches) {
		NSRange matchRange = [match range];
		if ([match resultType] == NSTextCheckingTypeLink) {
			NSURL *url = [match URL];
			NSString *URLString = [string substringWithRange:matchRange];
			NSAttributedString *linkedAttributedString = [self ys_hyperlinkFromString:URLString withURL:url];
			[attributedString replaceCharactersInRange:matchRange withAttributedString:linkedAttributedString];
		}
	}
	return attributedString;
}

@end
