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
- (NSDictionary *)queryDictionary;

+ (NSURL *)appStoreURLforApplicationIdentifier:(NSString *)identifier;

+ (NSURL *)appStoreReviewURLForApplicationIdentifier:(NSString *)identifier;

@end
