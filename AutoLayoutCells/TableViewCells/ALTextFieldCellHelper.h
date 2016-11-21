//
//  ALTextFieldHelper.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/11/14.
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

#import "ALTextCellConstants.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  `ALTextFieldCellHelper` encapsulates text field tasks common to `ALTextFieldCell` and `ALTextFieldOnlyCell`, such as text field configuration and setting text field values from a dictionary using pre-defined keys.
 *  @see `ALCellConstants` and `ALTextCellConstants` for pre-defined dictionary keys.
 */
@interface ALTextFieldCellHelper : NSObject <UITextFieldDelegate>

#pragma mark - Instance Properties

/**
 *  The cell that owns this text field helper (for transparently `ALTextCellDelegate` messages)
 */
@property (weak, nonatomic, nullable) UITableViewCell *cell;

/**
 *  The delegate to inform of height change and value-related events.
 *  @see `ALTextViewCellHelperDelegate` for more details
 */
@property (weak, nonatomic, nullable) id<ALCellDelegate>delegate;

/**
 *  The text field that should be configured, set values of, delegated for, etc
 */
@property (weak, nonatomic, nullable) UITextField *textField;

/**
 *  The block that should be called whenever the text field's value changes.
 *
 *  @discussion  This can be used in addition to, or as a replacement for, a `delegate`.
 *
 *  This block will be called *before* the `delegate` is messaged.
 */
@property (strong, nonatomic, nullable) void (^valueChangedBlock)(id value);

#pragma mark - Object Lifecycle

/**
 *  This is the designated intializer.
 *
 *  @param cell       The cell that owns this object (for transparently messaging the `delegate)
 *  @param textField  The text field that should be configured, set values of, delegated for, etc
 *
 *  @return A new instance of `ALTextViewCellHelper`
 */
- (instancetype)initWithCell:(UITableViewCell *)cell textField:(UITextField *)textField;

#pragma mark - Instance Methods

/**
 *  Use this method to set the `textView` values from a dictionary.
 *  @see `ALCellConstants` and `ALTextCellConstants` for pre-defined dictionary keys.
 *
 *  @param dictionary The dictionary containing the text field values
 */
- (void)setValuesFromDictionary:(NSDictionary *)dictionary;

/**
 *  Use this method to set the text cell type.
 *
 *  @param textCellType The text cell type.
 */
- (void)setTextCellType:(ALTextCellType)textCellType;

@end


@interface ALTextFieldCellHelper (Protected)

/**
*  This method is called whenever the text field receives the control event `UIControlEventEditingChanged`.
*
*  @param textField The text field
*/
- (void)textFieldDidChange:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
