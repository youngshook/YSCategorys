//
//  NSData+YSKit.h
//  YSCategorys
//
//  Created by YoungShook on 14-7-9.
//  Copyright (c) 2014年 YShook Station. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSData (YSKit)

- (NSData *) AES256EncryptWithKey:(NSString *)key;   // Encrypt
- (NSData *) AES256DecryptWithKey:(NSString *)key;   // Decrypt

@end
