//
//  ALTableView.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/5/14.
//
//

#import <UIKit/UIKit.h>

/**
 *  `ALTableView` will automatically call `reloadData` on itself in the event that it receives a `UIContentSizeCategoryDidChangeNotification` notification.
 */
@interface ALTableView : UITableView
@end

/**
 *  These methods should be considered "protected" and should only be called within this class or by subclasses.
 */
@interface ALTableView (Protected)

///--------------------------------------------------------------
/// @name Object Lifecycle
///--------------------------------------------------------------

/**
 *  Subclasses should use this method for common setup (`init`) code.
 *
 * @discussion The default implementation registers for `UIContentSizeCategoryDidChangeNotification` notifications. This method is called by all `init` methods after `self` has already been initialized.
 */
- (void)commonInit __attribute((objc_requires_super));

///--------------------------------------------------------------
/// @name Notifications
///--------------------------------------------------------------

/**
 *  This method is called whenever the`UIContentSizeCategoryDidChangeNotification` notification is received.
 *
 *  @discussion This method calls `reloadData` on itself, within a `dispatch_async` block on the main thread.
 *
 *  The reason `dispatch_async` is used is to allow AL cells the chance to update themselves first.
 *
 *  @param notification The `UIContentSizeCategoryDidChangeNotification` notification object.
 */
- (void)contentSizeCategoryDidChange:(NSNotification *)notification __attribute((objc_requires_super));

@end