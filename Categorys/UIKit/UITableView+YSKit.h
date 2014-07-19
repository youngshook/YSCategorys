/*!
    UITableView extension
    YSCategorys

    Copyright (c) 2013-2014 YoungShook
    https://github.com/youngshook/YSCategorys

    The MIT License (MIT)
    http://www.opensource.org/licenses/mit-license.php
 */

@interface UITableView (YSKit)

/**
   Deselects all selected rows, with an option to animate the deselection.

   @discussion Calling this method does not cause the delegate to receive a `tableView:willSelectRowAtIndexPath:` or `tableView:didSelectRowAtIndexPath: message`, nor will it send `UITableViewSelectionDidChangeNotification` notifications to observers.

   Calling this method does not cause any scrolling to the deselected row.

   @param animated
    YES if you want to animate the deselection and NO if the change should be immediate.
 */
- (void)ys_deselectRows:(BOOL)animated;

/**
   @abstract Returns a reusable table-view cell object located by its class. The cell´s reuseIdentifier must equal to its class name.

   @param cellClass The class of the cell object to be reused.

   @return A UITableViewCell object with the associated identifier or nil if no such object exists in the reusable-cell queue.
 */
- (id)ys_dequeueReusableCellWithClass:(Class)cellClass;

- (void)ys_reloadDataKeepSelection;
- (void)ys_reloadDataWithRowAnimation:(UITableViewRowAnimation)animation;

- (void)ys_selectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)ys_selectAllRowsAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;

- (CGSize)ys_cellSize;
- (CGSize)ys_cellSizeForIndexPath:(NSIndexPath *)indexPath;

- (void)ys_registerClassForCellWithDefaultReuseIdentifier:(Class)cellClass;
- (id)ys_dequeueReusableCellWithDefaultIdentifier;
- (id)ys_dequeueReusableCellWithDefaultIdentifierForIndexPath:(NSIndexPath *)indexPath;

- (void)ys_scrollToTop;
- (void)ys_scrollToTopAnimated:(BOOL)animated;

- (void)ys_scrollToBottom;
- (void)ys_scrollToBottomAnimated:(BOOL)animated;

@end
