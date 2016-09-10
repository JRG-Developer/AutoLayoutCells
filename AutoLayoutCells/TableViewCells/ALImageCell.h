//
//  ALImageCell.h
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

#import "ALCell.h"

/**
 *  `ALImageCell` shows a title, subtitle, and optional "main" and "secondary" images.
 *
 *  @discussion You should set the cell's values via `setValuesFromDictionary` instead of each property directly.
 *  @see `ALCellConstants` and `ALImageCellConstants`  for predefined dictionary value keys.
 */
@interface ALImageCell : ALCell

///--------------------------------------------------------------
/// @name Instance Properties
///--------------------------------------------------------------

/**
 *  The placeholder image to show whenever the `mainImageView` is loading.
 */
@property (strong, nonatomic) UIImage *mainImagePlaceholder UI_APPEARANCE_SELECTOR;

/**
 *  The placeholder image to show whenever the `secondaryImageView` is loading
 */
@property (strong, nonatomic) UIImage *secondaryImagePlaceholder UI_APPEARANCE_SELECTOR;

/**
 *  The style to be used to show a loading activity indicator.
 *
 *  @discussion This property is set to `NSNotFound` by default, meaning a loading activity indicator shouldn't be shown.
 */
@property (assign, nonatomic) NSInteger loadingActivityIndicatorStyle UI_APPEARANCE_SELECTOR;

///--------------------------------------------------------------
/// @name Main Image View Outlets
///--------------------------------------------------------------

/**
 *  The "main" image view that the cell displays. This should be the first/focus/largest image view the cell displays.
 *
 *  @note Setting this outlet is *optional*. 
 *
 *  @discussion Some cells inherit from this class but do *not* have a `mainImageView` in all of their `nibs` (e.g. `ALBooleanCell`, which has one nib that includes a `mainImageView` and another nib without it).
 */
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

/**
 *  The leading constraint on the `mainImageView`
 *
 *  @note Setting this outlet is *optional*.
 *
 *  @discussion This outlet is used to add/remove *leading* space (depending on whether `mainImageView` has an image set) before `mainImageView`.
 *
 *  If you always want to show leading space, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainImageViewLeadingConstraint;

/**
 *  The trailing constraint on the `mainImageView`
 *
 *  @note Setting this outlet is *optional*.
 *
 *  @discussion This outlet is used to add/remove *trailing* space (depending on whether `mainImageView` has an image set) before `mainImageView`.
 *
 *  If you always want to show trailing space, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainImageViewTrailingConstraint;

/**
 *  The height constraint on the `mainImageView`
 *
 *  @note Setting this outlet is *optional*
 *
 *  @discussion This outlet is used to remove (if a "main" image isn't set) or set (if a "main" image is set) the height of the `mainImageView`.
 *
 *  If you always want to show a constant height for the `mainImageView`, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainImageViewHeightConstraint;

/**
 *  The width constraint on the `mainImageView`
 *
 *  @note Setting this outlet is *optional*
 *
 *  @discussion This outlet is used to remove (if a "main" image isn't set) or set (if a "main" image is set) the width of the `mainImageView`.
 *
 *  If you always want to show a constant width for the `mainImageView`, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainImageViewWidthConstraint;

///--------------------------------------------------------------
/// @name Secondary Image View Constants
///--------------------------------------------------------------

/**
 *  The "secondary" image view that the cell displays. This should be the second/smaller image view the cell displays.
 *
 *  @note Setting this outlet is *optional*.
 *
 *  @discussion Some cells inherit from this class but do *not* have a `secondaryImageView` in all of their `nibs`.
 */
@property (weak, nonatomic) IBOutlet UIImageView *secondaryImageView;

/**
 *  The leading constraint on the `secondaryImageView`
 *
 *  @note Setting this outlet is *optional*.
 *
 *  @discussion This outlet is used to add/remove *leading* space (depending on whether `secondaryImageView` has an image set) before `secondaryImageView`.
 *
 *  If you always want to show leading space before `secondaryImageView`, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondaryImageViewLeadingConstraint;

/**
 *  The trailing constraint on the `secondaryImageView`
 *
 *  @note Setting this outlet is *optional*.
 *
 *  @discussion This outlet is used to add/remove *trailing* space (depending on whether `secondaryImageView` has an image set) before `secondaryImageView`.
 *
 *  If you always want to show trailing space, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondaryImageViewTrailingConstraint;

/**
 *  The height constraint on the `secondaryImageView`
 *
 *  @note Setting this outlet is *optional*
 *
 *  @discussion This outlet is used to remove (if a "secondary" image isn't set) or set (if a "secondary" image is set) the height of the `secondaryImageView`.
 *
 *  If you always want to show a constant height for the `secondaryImageView`, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondaryImageViewHeightConstraint;

/**
 *  The width constraint on the `secondaryImageView`
 *
 *  @note Setting this outlet is *optional*
 *
 *  @discussion This outlet is used to remove (if a "secondary" image isn't set) or set (if a "secondary" image is set) the width of the `secondaryImageView`.
 *
 *  If you always want to show a constant width for the `secondaryImageView`, you should *not* set this outlet.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondaryImageViewWidthConstraint;

/**
 *  Use this method to manually tell the cell to reset the original constraint values for its `mainImageView`
 */
- (void)resetMainImageViewConstraintConstants;

/**
 *  Use this method to manually tell the cell to set the constraint values for its `mainImageView` to zero.
 */
- (void)setMainImageViewConstraintsToZero;

/**
 *  Use this method to manually tell the cell to reset the original constraint values for its `secondaryImageView`
 */
- (void)resetSecondaryImageViewConstraintConstants;

/**
 *  Use this method to manually tell the cell to set the constraint values for its `secondaryImageView` to zero.
 */
- (void)setSecondaryImageViewConstraintsToZero;

@end

@interface ALImageCell (Protected)

///--------------------------------------------------------------
/// @name Protected Methods
///--------------------------------------------------------------

/**
 *  This method is called within `setValuesFromDictionary` to set the image of the `mainImageView`.
 *  @see `ALImageCellConstants` for predefined dictionary keys.
 *
 *  @param dictionary The dictionary containing the values to be set on the cell
*/
- (void)setMainImageViewFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method is called within `setValuesFromDictionary` to set the image of the `secondaryImageView`.
 *  @see `ALImageCellConstants` for predefined dictionary keys.
 *
 *  @param dictionary The dictionary containing the values to be set on the cell
 */
- (void)setSecondaryImageViewFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method first sets the `placeholderImage` on the `imageView`, asynchronously loads the image from the given url, and sets it on the image view.
 *
 *  @discussion This method uses the `sharedImageDownloadSession` to create an `NSURLSessionDownloadTask` and associates it with the image view. Before setting the placeholder image, the associated download session is cancelled.
 *
 *  @param url              The url to load the image from
 *  @param imageView        The image view to set the loaded image on
 *  @param placeholder      The placeholder image to set while loading
 */
- (void)setImageFromURL:(NSURL *)url
            onImageView:(UIImageView *)imageView
       placeholderImage:(UIImage *)placeholder;

@end
