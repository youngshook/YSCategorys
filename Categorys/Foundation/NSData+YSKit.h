/*!
    NSData extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSData (YSKit)

- (id)ys_JSONValue;
- (NSData *)ys_AES256EncryptWithKey:(NSString *)key;    // Encrypt
- (NSData *)ys_AES256DecryptWithKey:(NSString *)key;    // Decrypt

@end
