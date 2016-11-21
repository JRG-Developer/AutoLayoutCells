//
//  ALTextViewOnlyCell.h
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

#import "ALBaseCell.h"
#import "ALTextCellDelegate.h"

@class ALAutoResizingTextView;
@class ALTextViewCellHelper;

@protocol ALTextCellDelegate;

NS_ASSUME_NONNULL_BEGIN

/**
 *  `ALTextViewOnlyCell` shows just a text view to get input from the user.
 *
 *  @discussion You should set the cell's values via `setValuesFromDictionary` instead of each property directly.
 *  @see `ALTextCellConstants` for additional keys that may be specified in the dictionary.
 *
 *  @note The text view automatically resizes its height to fit the text input, and the cell notifies its `delegate` of such events so the table view can be updated appropriately.
 *  @see `ALTextCellDelegate` for more info.
 */
@interface ALTextViewOnlyCell : ALBaseCell

#pragma mark - Instance Preoperties

/**
 *  The text view helper, which encapsulates commmon text view configuration, delegate handling, etc
 */
@property (strong, nonatomic, readonly) ALTextViewCellHelper *textViewHelper;

#pragma mark - Outlets

/**
 *  The delegate to be notified of text view height change events.
 *  @see `ALTextCellDelegate` for more details
 */
@property (weak, nonatomic, nullable) IBOutlet id<ALTextCellDelegate>heightDelegate;

/**
 *  The text view, which accepts user input and resizes itself as needed
 *  @see `ALAutoResizingTextView` in `AutoLayoutTextViews` pod for more details
 */
@property (weak, nonatomic, nullable) IBOutlet ALAutoResizingTextView *textView;

#pragma mark - Dynamic Type Font

/**
 *  This method is called within `contentSizeCategoryDidChange:` to refresh the text view's font.
 *
 *  If your cell uses custom fonts and/or has additional text, label, etc views, you should subclass and override this method. Calling `[super refreshFonts]` is allowed  but is not required.
 */
- (void)refreshFonts;

@end

NS_ASSUME_NONNULL_END
