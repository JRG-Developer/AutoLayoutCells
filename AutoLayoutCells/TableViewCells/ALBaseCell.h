//
//  ALBaseCell.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 07/11/14.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

@import UIKit;

@protocol ALCellDelegate;

/**
 *  This is the base cell class for all table view cells within `AutoLayoutCells`.
 *
 *  @discussion You should set the cell's values via `setValuesDictionary` instead of each property directly.
 */
@interface ALBaseCell : UITableViewCell

///--------------------------------------------------------------
/// @name Instance Properties
///--------------------------------------------------------------

/**
 *  The delegated that should be notified of value-related events.
 *  @see `ALCellDelegate` for more details.
 */
@property (weak, nonatomic) id<ALCellDelegate>delegate;

/**
 *  The `valuesDictionary` that should be used to set the cell labels, value, etc.
 *  @see `ALCellConstants.h` and related files for keys you can use.
 */
@property (strong, nonatomic) NSDictionary *valuesDictionary;

/**
 *  Whether this cell should be treated as a sizing cell. The default value is `NO`.
 *
 *  @discussion Cell subclasses may treat sizing cells slightly differently than normal cells. In example, image loading from URL may be skipped.
 */
@property (assign, nonatomic) BOOL isSizingCell;

///--------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------

/**
 *  This is the setter for the `valuesDictionary` property. It's redudantly defined to add `__attribute((objc_requires_super))` so that subclasses of `ALBaseCell` will know to call the `super` implementation for this method.
 *
 *  @param valuesDictionary The dictionary to be set
 */
- (void)setValuesDictionary:(NSDictionary *)valuesDictionary __attribute((objc_requires_super));

@end

/**
 *  These methods should be considered "protected" and should only be called within this class or by subclasses.
 */
@interface ALBaseCell (Protected)

/**
 *  Subclasses should use this method for common setup (`init`) code.
 *  
 * @discussion The default implementation registers for `UIContentSizeCategoryDidChangeNotification` notifications. This method is called by all `init` methods after `self` has already been initialized.
 */
- (void)commonInit __attribute((objc_requires_super));

/**
 *  This method is called to get the notification center object.
 *
 *  @discussion This method is exposed for unit testing only. Outside of unit testing, you should not need to override this method.
 *
 *  @return `[NSNotficationCenter defaultCenter`]
 */
- (NSNotificationCenter *)notificationCenter;

/**
 *  Subclasses should use this method to "reset" the font of any dynamic type text labels, text views, etc. This method is called whenever the`UIContentSizeCategoryDidChangeNotification` notification is received.
 *
 *  @discussion The default implementation of this method is empty (but this may change in the future).
 *
 *  @param notification The `UIContentSizeCategoryDidChangeNotification` notification object.
 */
- (void)contentSizeCategoryDidChange:(NSNotification *)notification __attribute((objc_requires_super));

@end
