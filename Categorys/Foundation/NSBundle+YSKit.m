#import "NSBundle+YSKit.h"

@implementation NSBundle (YSKit)
+ (NSString *)ys_mainBundlePathForCaches {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/"];
}

+ (NSString *)ys_mainBundlePathForPreferences {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/"];
}

+ (NSString *)ys_mainBundlePathForDocuments {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/"];
}

+ (NSString *)ys_mainBundlePathForTemp {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/tmp/"];
}

+ (NSString *)ys_pathForMainBoundlePath:(NSString *)path {
	return [NSHomeDirectory() stringByAppendingPathComponent:path];
}

- (NSString *)ys_versionString {
	NSString *bundleVersion = self.infoDictionary[@"CFBundleVersion"];
	NSString *shortVersion = self.infoDictionary[@"CFBundleShortVersionString"];
	return [NSString stringWithFormat:@"%@.%@", shortVersion, bundleVersion];
}

@end
