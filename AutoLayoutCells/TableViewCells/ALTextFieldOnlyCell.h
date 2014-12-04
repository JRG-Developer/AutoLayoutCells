//
//  ALTextFieldOnlyCell.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/14/14.
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

@protocol ALCellDelegate;
@class ALTextFieldCellHelper;

/**
 *  `ALTextFieldCell` shows just a `textField` to get input from the user.
 *  @see `ALCellConstants` and  `ALTextCellConstants` for predefined dictionary keys.
 */
@interface ALTextFieldOnlyCell : ALBaseCell

///--------------------------------------------------------------
/// @name Instance Properties
///--------------------------------------------------------------

/**
*  The delegated that should be notified of value-related events.
*  @see `ALCellDelegate` for more details.
*/
@property (weak, nonatomic) IBOutlet id<ALCellDelegate> delegate;

/**
 *  The text field helper, which encapsulates commmon text field configuration, delegate handling, etc
 */
@property (strong, nonatomic, readonly) ALTextFieldCellHelper *textFieldHelper;

///--------------------------------------------------------------
/// @name Outlets
///--------------------------------------------------------------

/**
 *  The text field
 */
@property (weak, nonatomic) IBOutlet UITextField *textField;

///--------------------------------------------------------------
/// @name Dynamic Type Font
///--------------------------------------------------------------

/**
 *  This method is called within `contentSizeCategoryDidChange:` to refresh the text field's font.
 *
 *  If your cell uses custom fonts and/or has additional text, label, etc views, you should subclass and override this method. Calling `[super refreshFonts]` is allowed  but is not required.
 */
- (void)refreshFonts;

@end
