#import "UIDevice+YSKit.h"
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation UIDevice (YSKit)

- (BOOL)ys_isPad {
	static BOOL isPad = NO;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    if ([self userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	        isPad = YES;
		}
	});
	return isPad;
}

- (BOOL)ys_isRetinaDisplay {
	static BOOL isRetinaDisplay = NO;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
	        && [UIScreen mainScreen].scale == 2.0) {
	        isRetinaDisplay = YES;
		}
	});
	return isRetinaDisplay;
}

- (long long)ys_fileSystemFreeSize {
	NSError *e = nil;
	NSDictionary *info = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&e];
	if (e) NSLog(@"Can`t get file system free size, reason: %@", e);
	return [info[NSFileSystemFreeSize] longLongValue];
}

- (long long)ys_fileSystemSize {
	NSError *e = nil;
	NSDictionary *info = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&e];
	if (e) NSLog(@"Can`t get file system size, reason: %@", e);
	return [info[NSFileSystemSize] longLongValue];
}

- (BOOL)ys_isBeingDebugged {
	int junk;
	int mib[4];
	struct kinfo_proc info;
	size_t size;

	// Initialize the flags so that, if sysctl fails for some bizarre
	// reason, we get a predictable result.
	info.kp_proc.p_flag = 0;

	// Initialize mib, which tells sysctl the info we want, in this case
	// we're looking for information about a specific process ID.
	mib[0] = CTL_KERN;
	mib[1] = KERN_PROC;
	mib[2] = KERN_PROC_PID;
	mib[3] = getpid();

	// Call sysctl.
	size = sizeof(info);
	junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
	assert(junk == 0);

	// We're being debugged if the P_TRACED flag is set.
	return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

@end
