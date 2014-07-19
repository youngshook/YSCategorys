#import "NSURL+YSKit.h"

@implementation NSURL (YSKit)

- (NSDictionary *)ys_queryDictionary {
	NSString *queryString = [self query];
	if (!queryString) return nil;

	NSMutableDictionary *queryDictionary = [NSMutableDictionary dictionary];

	NSCharacterSet *charSetAmpersand = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	NSCharacterSet *charSetEqualsSign = [NSCharacterSet characterSetWithCharactersInString:@"="];
	for (NSString *fieldValuePair in[queryString componentsSeparatedByCharactersInSet:charSetAmpersand]) {
		NSArray *fieldValueArray = [fieldValuePair componentsSeparatedByCharactersInSet:charSetEqualsSign];
		if (fieldValueArray.count == 2) {
			NSString *filed = [fieldValueArray objectAtIndex:0];
			NSString *value = [fieldValueArray objectAtIndex:1];
			[queryDictionary setObject:[value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:filed];
		}
	}
	return queryDictionary;
}

+ (NSURL *)ys_appStoreURLforApplicationIdentifier:(NSString *)identifier {
	NSString *link = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@?mt=8", identifier];

	return [NSURL URLWithString:link];
}

+ (NSURL *)ys_appStoreReviewURLForApplicationIdentifier:(NSString *)identifier {
	NSString *link = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", identifier];
	return [NSURL URLWithString:link];
}

@end
