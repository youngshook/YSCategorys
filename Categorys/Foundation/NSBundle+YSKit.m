
#import "YSKit.h"
#import "NSBundle+YSKit.h"

@implementation NSBundle (YSKit)
+ (NSString *)mainBundlePathForCaches {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/"];
}

+ (NSString *)mainBundlePathForPreferences {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/"];
}

+ (NSString *)mainBundlePathForDocuments {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/"];
}

+ (NSString *)mainBundlePathForTemp {
	return [NSHomeDirectory() stringByAppendingPathComponent:@"/tmp/"];
}

+ (NSString *)pathForMainBoundlePath:(NSString *)path {
    return [NSHomeDirectory() stringByAppendingPathComponent:path];
}

- (NSString *)versionString {
    NSString *bundleVersion = self.infoDictionary[@"CFBundleVersion"];
    NSString *shortVersion = self.infoDictionary[@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@.%@", shortVersion, bundleVersion];
}

@end
