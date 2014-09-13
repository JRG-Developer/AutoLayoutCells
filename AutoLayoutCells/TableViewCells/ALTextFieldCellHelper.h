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

/**
 *  `ALTextFieldCellHelper` encapsulates text field tasks common to `ALTextFieldCell` and `ALTextFieldOnlyCell`, such as text field configuration and setting text field values from a `valuesDictionary` using pre-defined keys.
 *  @see `ALCellConstants` and `ALTextCellConstants` for pre-defined dictionary keys.
 */
@interface ALTextFieldCellHelper : NSObject <UITextFieldDelegate>

/**
 *  The cell that owns this text field helper (for transparently `ALTextCellDelegate` messages)
 */
@property (weak, nonatomic) UITableViewCell *cell;

/**
 *  The text field that should be configured, set values of, delegated for, etc
 */
@property (weak, nonatomic) UITextField *textField;

/**
 *  The delegate to inform of height change and value-related events
 *  @see `ALTextViewCellHelperDelegate` for more details
 */
@property (nonatomic, weak) id<ALCellDelegate>delegate;

///--------------------------------------------------------------
/// @name Object Lifecycle
///--------------------------------------------------------------

/**
 *  This is the designated intializer.
 *
 *  @param cell       The cell that owns this object (for transparently messaging the `delegate)
 *  @param textField  The text field that should be configured, set values of, delegated for, etc
 *
 *  @return A new instance of `ALTextViewCellHelper`
 */
- (instancetype)initWithCell:(UITableViewCell *)cell textField:(UITextField *)textField;

///--------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------

/**
 *  Use this method to set the `textView` values given a `valuesDictionary`.
 *  @see `ALCellConstants` and `ALTextCellConstants` for pre-defined dictionary keys.
 *
 *  @param valuesDictionary The dictionary containing the text field values
 */
- (void)setValuesFromDictionary:(NSDictionary *)valuesDictionary;

@end
