//
//  ALTextViewCellHelper.h
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

#import <AutoLayoutTextViews/ALAutoResizingTextView.h>
@protocol ALTextCellDelegate;

/**
 *  `ALTextViewCellHelper` encapsulates text view tasks common to `ALTextViewCell` and `ALTextViewOnlyCell`, such as text view configuration and setting text view values from a `valuesDictionary` using pre-defined keys.
 *  @see `ALCellConstants` and `ALTextCellConstants` for pre-defined dictionary keys.
 */
@interface ALTextViewCellHelper : NSObject <ALAutoResizingTextViewDelegate>

/**
 *  The cell that owns this text view helper (for transparently `ALTextCellDelegate` messages)
 */
@property (weak, nonatomic) UITableViewCell *cell;

/**
 *  The delegate to inform of height change and value-related events
 *  @see `ALTextViewCellHelperDelegate` for more details
 */
@property (nonatomic, weak) id<ALTextCellDelegate>delegate;

///--------------------------------------------------------------
/// @name Object Lifecycle
///--------------------------------------------------------------

/**
 *  This is the designated intializer.
 *
 *  @param cell The cell that owns this object (for transparently messaging the `delegate)
 *
 *  @return A new instance of `ALTextViewCellHelper`
 */
- (instancetype)initWithCell:(UITableViewCell *)cell;

///--------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------

/**
 *  This method configures the appearance of the `textView`.
 *
 *  @param textView The text view to be configured
 */
- (void)configureTextView:(ALPlaceholderTextView *)textView;

/**
 *  Use this method to set the `textView` values given a `valuesDictionary`.
 *  @see `ALCellConstants` and `ALTextCellConstants` for pre-defined dictionary keys.
 *
 *  @param textView         The text view whose values will be set
 *  @param valuesDictionary The dictionary containing the text view values
 */
- (void)textView:(ALPlaceholderTextView *)textView setValuesFromDictionary:(NSDictionary *)valuesDictionary;

@end
