/*!
    NSURL extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSURL (YSKit)

/**	Cover query string into NSDictionary
 */
- (NSDictionary *)ys_queryDictionary;

+ (NSURL *)ys_appStoreURLforApplicationIdentifier:(NSString *)identifier;

+ (NSURL *)ys_appStoreReviewURLForApplicationIdentifier:(NSString *)identifier;

@end
