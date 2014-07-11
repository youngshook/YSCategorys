
#import "NSNotificationCenter+YSKit.h"

@implementation NSNotificationCenter (YSKit)

+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
	[[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:anObject];
}

+ (void)postNotification:(NSNotification *)notification
{
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}

+ (void)postNotificationName:(NSString *)aName object:(id)anObject
{
	[[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
}

+ (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
	[[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
}

+ (void)removeObserver:(id)observer
{
	[[NSNotificationCenter defaultCenter] removeObserver:observer];
}

+ (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:anObject];
}

#if NS_BLOCKS_AVAILABLE
+ (id)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block
{
	return [[NSNotificationCenter defaultCenter] addObserverForName:name object:obj queue:queue usingBlock:block];
}
#endif

+ (void)postNotificationOnMainThread:(NSNotification *)notification
{
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	});
}

+ (void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject
{
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
	});
}

+ (void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
	});
}

@end
