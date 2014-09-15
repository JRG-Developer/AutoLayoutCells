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
 *  This method is called to inform the delegate that the cell's height will change.
  *
 *  @discussion This method is called when the *text view's height* will change. It's possible that the cell height *may not* actually change (i.e. another label may be taller than the text view and determine the height should actually be larger than the height required by the text view).
 *  
 *  Regardless, you should implement this delegate method if you want to respond to height-will-change events on the cell.
 *
 *  @param cell The cell whose height will change
 */
- (void)cellHeightWillChange:(id)cell;

/**
 *  This method is called to inform the delegate that the cell's height did change.
 *
 *  @discussion This method is called when the *text view's height* did change. It's possible that the cell height *may not* have actually changed (i.e. another label may be taller than the text view and determine the height should actually be larger than the height required by the text view).
 *
 *  Regardless, you should implement this delegate method if you want to respond to height-did-change events on the cell.
 *
 *  @param cell The cell whose height did change
 */
- (void)cellHeightDidChange:(id)cell;

@end
