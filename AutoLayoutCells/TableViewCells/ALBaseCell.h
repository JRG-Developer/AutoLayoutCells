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

NS_ASSUME_NONNULL_BEGIN

/**
 *  This is the base cell class for all table view cells within `AutoLayoutCells`.
 *
 *  @discussion You should set the cell's values via `setValuesFromDictionary` instead of each property directly.
 *  @see `ALCellConstants` for predefined dictionary value keys.
 */
@interface ALBaseCell : UITableViewCell

#pragma mark - Instance Properties

/**
 *  The delegate that should be notified of value-related events.
 *
 *  @discussion Each cell will have a `delegate` object. While `ALCellDelegate` is the most commonly required delegate protocol, it doesn't strictly have to be.
 */
@property (weak, nonatomic, nullable) IBOutlet id delegate;

/**
 *  Whether this cell should be treated as a sizing cell. The default value is `NO`.
 *
 *  @discussion Cell subclasses may treat sizing cells slightly differently than normal cells. In example, image loading from URL may be skipped.
 */
@property (assign, nonatomic) BOOL isSizingCell;

/**
 *  The block that should be called whenever the cell's value changes.
 *
 *  @discussion  This can be used in addition to, or as a replacement for, a `delegate`.
 *
 *  This block will be called *before* the `delegate` is messaged.
 */
@property (strong, nonatomic, nullable) void (^valueChangedBlock)(id value);


/**
 *  Whether or not this cell should have "view only" behavior. The default value is `NO`.
 *
 *  @discussion  Cell subclasses may override this setter to perform custom configuration (e.g. user interactions, etc) for when the cell is in "view only" mode.
 */
@property (assign, nonatomic) BOOL isViewOnly;

#pragma mark - Class Configuration

/**
 *  Use this method to set whether instances should register for `UIContentSizeCategoryDidChangeNotification` notifications. Defaults to `YES`.
 *
 *  @warning  You should set this *before* any cells are created.
 *
 *  @param  shouldRegister  `YES` to register for `UIContentSizeCategoryDidChangeNotification` notification or `NO` to not register
 */
+ (void)setShouldRegisterForFontChanges:(BOOL)shouldRegister;

/**
 *  Whether instances should register for `UIContentSizeCategoryDidChangeNotification` notifications. Defaults to `YES`.
 *
 *  @discussion  You can change this value via `setShouldRegisterForFontChanges:`. However, you should set this *before* any cells are created.
 *
 *  @return `YES` to register for `UIContentSizeCategoryDidChangeNotification` notification or `NO` to not register
 */
+ (BOOL)shouldRegisterForFontChanges;

#pragma mark - Instance Methods

/**
 *  Use this method to set the cell's values from the given dictionary using pre-defined keys.
 *  @see `ALCellConstants` for predefined dictionary value keys.
 *
 *  @param dictionary The dictionary containing the values to be set on the cell
 */
- (void)setValuesFromDictionary:(NSDictionary *)dictionary __attribute((objc_requires_super));

@end


@interface ALBaseCell (Protected)

/**
 *  Subclasses should use this method for common setup (`init`) code.
 *  
 * @discussion The default implementation registers for `UIContentSizeCategoryDidChangeNotification` notifications. This method is called by all `init` methods after `self` has already been initialized.
 */
- (void)commonInit __attribute((objc_requires_super));

/**
 *  Subclasses should use this method to "reset" the font of any dynamic type text labels, text views, etc. This method is called whenever the`UIContentSizeCategoryDidChangeNotification` notification is received.
 *
 *  @discussion The default implementation of this method is empty (but this may change in the future).
 *
 *  @param notification The `UIContentSizeCategoryDidChangeNotification` notification object.
 */
- (void)contentSizeCategoryDidChange:(NSNotification *)notification __attribute((objc_requires_super));

@end

NS_ASSUME_NONNULL_END
