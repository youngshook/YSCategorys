
#import "UIStoryboard+YSKit.h"

@implementation UIStoryboard (YSKit)

- (id)instantiateViewControllerWithIdentifierUsingClass:(Class)viewControllerClass {
    return [self instantiateViewControllerWithIdentifier:NSStringFromClass(viewControllerClass)];
}

@end
