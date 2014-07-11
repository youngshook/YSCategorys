/*!
	NSNotificationCenter extension
	YSCategorys
 
	Copyright (c) 2013-2014 YoungShook
	https://github.com/youngshook/YSCategorys
 
	The MIT License (MIT)
	http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (YSKit)

+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

+ (void)postNotification:(NSNotification *)notification;
+ (void)postNotificationName:(NSString *)aName object:(id)anObject;
+ (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

+ (void)removeObserver:(id)observer;
+ (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

#if NS_BLOCKS_AVAILABLE
+ (id)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block;
#endif

+ (void)postNotificationOnMainThread:(NSNotification *)notification;
+ (void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject;
+ (void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end
