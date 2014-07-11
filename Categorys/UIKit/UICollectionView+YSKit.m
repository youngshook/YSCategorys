
#import "UICollectionView+YSKit.h"

#define NLDefaultCellIdentifier @"NLDefaultCellIdentifier"

@implementation UICollectionView (YSKit)

- (void)reloadDataKeepSelection
{
	NSArray* selectedItems = [self indexPathsForSelectedItems];
	
	[self reloadData];
	[self selectItemsAtIndexPaths:selectedItems animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)selectItemsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition
{
	for (NSIndexPath* indexPath in indexPaths)
		[self selectItemAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
}

- (void)selectAllItemsAnimated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition
{
	for (NSInteger i = 0; i < [self numberOfSections]; i++)
		for (NSInteger j = 0; j < [self numberOfItemsInSection:i]; j++)
			[self selectItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i] animated:animated scrollPosition:scrollPosition];
}

- (void)registerClassForCellWithDefaultReuseIdentifier:(Class)cellClass
{
	[self registerClass:cellClass forCellWithReuseIdentifier:NLDefaultCellIdentifier];
}

- (id)dequeueReusableCellWithDefaultReuseIdentifierForIndexPath:(NSIndexPath *)indexPath
{
	return [self dequeueReusableCellWithReuseIdentifier:NLDefaultCellIdentifier forIndexPath:indexPath];
}


@end
