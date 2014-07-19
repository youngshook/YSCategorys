#import "UICollectionView+YSKit.h"

#define NLDefaultCellIdentifier @"NLDefaultCellIdentifier"

@implementation UICollectionView (YSKit)

- (void)ys_reloadDataKeepSelection {
	NSArray *selectedItems = [self indexPathsForSelectedItems];

	[self reloadData];
	[self ys_selectItemsAtIndexPaths:selectedItems animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)ys_selectItemsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition {
	for (NSIndexPath *indexPath in indexPaths)
		[self selectItemAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
}

- (void)ys_selectAllItemsAnimated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition {
	for (NSInteger i = 0; i < [self numberOfSections]; i++)
		for (NSInteger j = 0; j < [self numberOfItemsInSection:i]; j++)
			[self selectItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i] animated:animated scrollPosition:scrollPosition];
}

- (void)ys_registerClassForCellWithDefaultReuseIdentifier:(Class)cellClass {
	[self registerClass:cellClass forCellWithReuseIdentifier:NLDefaultCellIdentifier];
}

- (id)ys_dequeueReusableCellWithDefaultReuseIdentifierForIndexPath:(NSIndexPath *)indexPath {
	return [self dequeueReusableCellWithReuseIdentifier:NLDefaultCellIdentifier forIndexPath:indexPath];
}

@end
