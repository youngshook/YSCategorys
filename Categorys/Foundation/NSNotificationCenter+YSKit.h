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

+ (void)ys_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

+ (void)ys_postNotification:(NSNotification *)notification;
+ (void)ys_postNotificationName:(NSString *)aName object:(id)anObject;
+ (void)ys_postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

+ (void)ys_removeObserver:(id)observer;
+ (void)ys_removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

#if NS_BLOCKS_AVAILABLE
+ (id)ys_addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block;
#endif

+ (void)ys_postNotificationOnMainThread:(NSNotification *)notification;
+ (void)ys_postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject;
+ (void)ys_postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end
