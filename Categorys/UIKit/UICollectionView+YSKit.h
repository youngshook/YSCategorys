/*!
	UICollectionView extension
	YSCategorys
 
	Copyright (c) 2013-2014 YoungShook
	https://github.com/youngshook/YSCategorys
 
	The MIT License (MIT)
	http://www.opensource.org/licenses/mit-license.php
 */

#import <UIKit/UIKit.h>

@interface UICollectionView (YSKit)

- (void)reloadDataKeepSelection;

- (void)selectItemsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;
- (void)selectAllItemsAnimated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;

- (void)registerClassForCellWithDefaultReuseIdentifier:(Class)cellClass;
- (id)dequeueReusableCellWithDefaultReuseIdentifierForIndexPath:(NSIndexPath *)indexPath;


@end
