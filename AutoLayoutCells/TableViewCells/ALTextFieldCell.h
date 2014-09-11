//
//  ALTextFieldCell.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/10/14.
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
 *  `ALTextFieldCell` shows a `title`, `subtitle`, and `textField` to get input from the user.
 */
@interface ALTextFieldCell : ALCell <UITextFieldDelegate>

/**
 *  The text field
 */
@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

/**
 *  These methods should be considered "protected" and should only be called by this class/subclass or unit testing.
 */
@interface ALTextFieldCell (Protected)

///--------------------------------------------------------------
/// @name Set Values Dictionary
///--------------------------------------------------------------

/**
 *  This method sets the `text` on the `textField` from the given dictionary.
 *  @see `ALCellConstants` value keys
 *
 *  @param dictionary The dictionary containing the text value
 */
- (void)setTextFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method sets the `placeholder` on the `textField` from the given dictionary.
 *
 *  @see `ALTextCellPlaceholderTextKey` key in `ALCellConstants`
 *
 *  @param dictionary The dictionary containing the placeholder value
 */
- (void)setTextPlaceholderFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method configures the `textField` based on the type (`ALTextCellType`) from the dictionary.
 *  @see `ALTextCellConstants` for `ALTextCellType` enum
 *
 *  @param dictionary The dictionary containing the type value
 */
- (void)setTextInputStyleFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypeEmail`
 *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypeEmail:(UITextField *)textField;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypeName`
 *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypeName:(UITextField *)textField;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypeNoChecking`
 *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypeNoChecking:(UITextField *)textField;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypePassword`
 *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypePassword:(UITextField *)textField;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypeSentences`
 *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypeSentences:(UITextField *)textField;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypeNumber`
 *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypeNumber:(UITextField *)textField;

/**
 *  This method is called by `setTextInputStyleFromDictionary:` to configure the text field as `ALTextCellTypeDefault`
 * *
 *  @param textField  The text field to be configured.
 */
- (void)setTextFieldTypeDefault:(UITextField *)textField;

///--------------------------------------------------------------
/// @name Text Field Actions
///--------------------------------------------------------------

/**
 *  This method is part of `UITextFieldDelegate`. It's provided here to indicate that `ALTextFieldCell` implements it.
 *
 *  @discussion This method messages the `delegate` that `cellWillBeginEditing`.
 *
 *  @param textField The text field that send the event
 */
- (void)textFieldWillBeginEditing:(UITextField *)textField;

/**
 *  This method is called for the control event `UIControlEventEditingChanged` on `textField`.
 *
 *  @discussion This method messages the `delegate` that `cell:valueChanged:`.
 *
 *  @param textField The text field that send the event
 */
- (void)textFieldValueChanged:(UITextField *)textField;

/**
 *  This method is part of `UITextFieldDelegate`. It's provided here to indicate that `ALTextFieldCell` implements it.
 *
 *  @discussion This method messages the `delegate` that `cell:didEndEditing:`.
 *
 *  @param textField The text field that send the event
 */
- (void)textFieldDidEndEditing:(UITextField *)textField;

/**
 *  This method is part of `UITextFieldDelegate`. It's provided here to indicate that `ALTextFieldCell` implements it.
 *
 *  @discussion This method sends `resignFirstResponder` to the text field and returns `NO`.
 *
 *  @param textField The text field that send the event
 *
 *  @return Always returns `NO`
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
