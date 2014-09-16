/*!
    NSObject extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSObject (YSKit)

- (NSArray *)ys_getPropertyKeys;
- (NSMutableDictionary *)ys_getProperties;
- (void)ys_reflectDataFromObject:(id)dataSource;

/**
   Adds a new instance method to a class. All instances of this class will have this method.

   The block captures `self` in the calling context. To allow access to the instance from within the block it is passed as parameter to the block.
   @param selectorName The name of the method.
   @param block The block to execute for the instance method, a pointer to the instance is passed as the only parameter.
   @returns `YES` if the operation was successful
 */
+ (BOOL)ys_addInstanceMethodWithSelectorName:(NSString *)selectorName block:(void (^)(id))block;

/**
   Exchanges two method implementations. After the call methods to the first selector will now go to the second one and vice versa.
   @param selector The first method
   @param otherSelector The second method
 */
+ (void)ys_swizzleMethod:(SEL)selector withMethod:(SEL)otherSelector;


/**
   Exchanges two class method implementations. After the call methods to the first selector will now go to the second one and vice versa.
   @param selector The first method
   @param otherSelector The second method
 */
+ (void)ys_swizzleClassMethod:(SEL)selector withMethod:(SEL)otherSelector;

//!https://github.com/youngshook/YSDynamicProperties

+ (void)ys_implementDynamicPropertyAccessors;
+ (void)ys_implementDynamicPropertyAccessorsForPropertyName:(NSString *)propertyName;
+ (void)ys_implementDynamicPropertyAccessorsForPropertyMatching:(NSString *)regexString;

@end
