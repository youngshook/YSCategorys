
#import "UITableView+YSKit.h"

#define YSDefaultCellIdentifier	@"YSDefaultCellIdentifier"

@implementation UITableView (YSKit)

- (void)deselectRows:(BOOL)animated {
    for (NSIndexPath *row in self.indexPathsForSelectedRows) {
	[self deselectRowAtIndexPath:row animated:animated];
    }
}

- (id)dequeueReusableCellWithClass:(Class)cellClass {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}

- (void)reloadDataKeepSelection
{
	NSArray* indexPaths = nil;
	
	if ([self respondsToSelector:@selector(indexPathsForSelectedRows)])
		indexPaths = [self performSelector:@selector(indexPathsForSelectedRows)];
	else
		indexPaths = [NSArray arrayWithObject:[self indexPathForSelectedRow]];
	
	[self reloadData];
	[self selectRowsAtIndexPaths:indexPaths animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation
{
	[self reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfSections])] withRowAnimation:animation];
}

- (void)selectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
	for (NSIndexPath* indexPath in indexPaths)
		[self selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
}

- (void)selectAllRowsAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
	for (NSUInteger i = 0; i < [self numberOfSections]; i++)
		for (NSUInteger j = 0; j < [self numberOfRowsInSection:i]; j++)
			[self selectRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i] animated:animated scrollPosition:scrollPosition];
}

- (CGSize)cellSize
{
	return [self cellSizeForIndexPath:nil];
}

- (CGSize)cellSizeForIndexPath:(NSIndexPath *)indexPath
{
	CGFloat modifier = [self style] == UITableViewStylePlain ? 0.f : 20.f;
	CGFloat height;
	
	if (indexPath && [[self delegate] respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
		height = [[self delegate] tableView:self heightForRowAtIndexPath:indexPath];
	else
		height = [self rowHeight];
	
	return CGSizeMake(CGRectGetWidth([self bounds]) - modifier, height);
}

- (void)registerClassForCellWithDefaultReuseIdentifier:(Class)cellClass
{
	[self registerClass:cellClass forCellReuseIdentifier:YSDefaultCellIdentifier];
}

- (id)dequeueReusableCellWithDefaultIdentifier
{
	return [self dequeueReusableCellWithIdentifier:YSDefaultCellIdentifier];
}

- (id)dequeueReusableCellWithDefaultIdentifierForIndexPath:(NSIndexPath *)indexPath
{
	return [self dequeueReusableCellWithIdentifier:YSDefaultCellIdentifier forIndexPath:indexPath];
}

- (void)scrollToTop
{
	[self scrollToTopAnimated:NO];
}

- (void)scrollToTopAnimated:(BOOL)animated
{
	CGRect rect = {0.f, 0.f, CGRectGetWidth([self bounds]), 1.f};
	
	[self scrollRectToVisible:rect animated:animated];
}

- (void)scrollToBottom
{
	[self scrollToBottomAnimated:NO];
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
	CGRect rect = {0.f, [self contentSize].height - 1.f, CGRectGetWidth([self bounds]), 1.f};
	
	[self scrollRectToVisible:rect animated:animated];
}

@end
