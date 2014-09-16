//
//  ALBooleanCell.h
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

#import "ALImageCell.h"

/**
 *  `ALBooleanCell` shows a title, subtitle, toggle, and optional image (depending on the nib) to represent a `boolean` value.
 *
 *  @discussion You should set the cell's values via `setValuesFromDictionary` instead of each property directly.
 *  @see `ALCellConstants` for predefined dictionary value keys.
 */
@interface ALBooleanCell : ALImageCell

///--------------------------------------------------------------
/// @name Outlets
///--------------------------------------------------------------

/**
 *  The toggle, representing the `boolean` value
 */
@property (weak, nonatomic) IBOutlet UISwitch *toggle;

///--------------------------------------------------------------
/// @name Actions
///--------------------------------------------------------------

/**
 *  This method is called whenever the user toggles the `toggle`
 *
 *  @warning If you subclass `ALBooleanCell`, make sure you connect this `IBAction` to the `UIControlEventValueChanged` on `toggle`.
 *
 *  @param toggle The `toggle` which sent the event
 */
- (IBAction)didToggle:(UISwitch *)toggle;

@end

@interface ALBooleanCell (Protected)

/**
 *  This method is called within `setValuesDictionary:` to set the `toggle` value
 *  @see `ALCellConstants.h` value keys
 *
 *  @param dictionary The dictionary containing the values to be set on the cell
 */
- (void)setToggleValueFromDictionary:(NSDictionary *)dictionary;

@end
