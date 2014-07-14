//
//  ALTextOnlyCell.h
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
#import "ALTextViewHelperDelegate.h"

@class ALAutoResizingTextView;
@protocol ALTextCellDelegate;

/**
 *  `ALTextOnlyCell` shows just a text view to get input from the user.
 */
@interface ALTextOnlyCell : ALBaseCell <ALTextViewHelperDelegate>

/**
 *  The delegate to be notified of text view height changes and value-related events.
 *  @see `ALTextCellDelegate` for more details
 */
@property (weak, nonatomic) id<ALCellDelegate, ALTextCellDelegate>delegate;

/**
 *  The text view helper, which takes care of configuring the text view
 *  @see `ALTextViewHelper` for more details
 */
@property (strong, nonatomic) ALTextViewHelper *textViewHelper;

/**
 *  The text view, which accepts user input and resizes itself as needed
 *  @see `ALAutoResizingTextView` in `AutoLayoutTextViews` pod for more details
 */
@property (weak, nonatomic) IBOutlet ALAutoResizingTextView *textView;

@end
