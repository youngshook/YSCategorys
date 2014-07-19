/*!
    NSOperationQueue extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

#import <Foundation/Foundation.h>

@interface NSOperationQueue (YSKit)

+ (instancetype)ys_sharedQueue;

- (void)ys_addFIFOOperation:(NSOperation *)fifoOperation;
- (void)ys_addLIFOOperation:(NSOperation *)lifoOperation;

@end
