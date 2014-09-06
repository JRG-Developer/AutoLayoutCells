//
//  ALTextCellDelegate.h
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

#import "ALCellDelegate.h"

/**
 *  `ALTextCellDelegate` extends `ALCellDelegate` to add optional methods to inform the delegate of text view height changed events.
 *  @discussion While these methods are "optional", the delegate **should** implement at least one of these in order to update the cell height to correctly display the text view within the cell.
 */
@protocol ALTextCellDelegate <ALCellDelegate>
@optional

/**
 *  This method is called to inform the delegate that the text view height will change.
 *
 *  @param cell      The cell whose text view will change its height
 *  @param textView  The text view that will change its height
 *  @param oldHeight The old height of the text view
 *  @param newHeight The new height of the text view
 */
- (void)cell:(id)cell textView:(UITextView *)textView
        willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight;

/**
 *  This method is called to inform the delegate that the text view height did change.
 *
 *  @param cell      The cell whose text view did change its height
 *  @param textView  The text view that did change its height
 *  @param oldHeight The old height of the text view
 *  @param newHeight The new height of the text view
 */
- (void)cell:(id)cell textView:(UITextView *)textView
        didChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight;

@end
