
#import "NSOperationQueue+YSKit.h"

@implementation NSOperationQueue (YSKit)

+ (instancetype)sharedQueue
{
	static NSOperationQueue* instance	= nil;
	static dispatch_once_t token		= 0;
	
	dispatch_once(&token, ^{
		
		instance = [[self alloc] init];
		[instance setMaxConcurrentOperationCount:4];
	});
	
	return instance;
}

- (void)addFIFOOperation:(NSOperation *)fifoOperation
{
	[self addOperation:fifoOperation];
}

- (void)addLIFOOperation:(NSOperation *)lifoOperation
{
	BOOL suspended		= [self isSuspended];
	NSArray* operations = [self operations];
	
	[self setSuspended:YES];
	
	for (NSOperation* operation in operations) {
		
		if (![operation isExecuting]) {
			
			[operation addDependency:lifoOperation];
			break;
		}
	}
	
	[self addOperation:lifoOperation];
	[self setSuspended:suspended];
}

@end
