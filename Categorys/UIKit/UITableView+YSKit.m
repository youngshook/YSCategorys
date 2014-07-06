
#import "UITableView+YSKit.h"

@implementation UITableView (YSKit)

- (void)deselectRows:(BOOL)animated {
    for (NSIndexPath *row in self.indexPathsForSelectedRows) {
	[self deselectRowAtIndexPath:row animated:animated];
    }
}

- (id)dequeueReusableCellWithClass:(Class)cellClass {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}

@end
