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

- (void)ys_reloadDataKeepSelection;

- (void)ys_selectItemsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;
- (void)ys_selectAllItemsAnimated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;

- (void)ys_registerClassForCellWithDefaultReuseIdentifier:(Class)cellClass;
- (id)ys_dequeueReusableCellWithDefaultReuseIdentifierForIndexPath:(NSIndexPath *)indexPath;


@end
