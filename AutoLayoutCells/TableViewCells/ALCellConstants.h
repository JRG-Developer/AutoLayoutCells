//
//  ALCellConstants.h
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

/**
 *  `ALCell` and subclasses look for these keys in order to set the relevant text/values on their cell subviews.
 */

/**
 *  Use this key to specify a title string.
 */
extern NSString * const ALCellTitleKey;                 // title

/**
 *  Use this key to specify an attributed title string.
 */
extern NSString * const ALCellAttributedTitleKey;       // attrTitle

/**
 *  Use this key to specify a subtitle string.
 */
extern NSString * const ALCellSubtitleKey;              // subtitle

/**
 *  Use this key to specify an attributed subtitle string.
 */
extern NSString * const ALCellAttributedSubtitleKey;    // attrSubtitle

/**
 *  Use this key to specify the value to be set on the cell.
 *
 *  @discussion Each cell type uses this value differently. In example, `ALBooleanCell` looks for an `NSNumber` with a `boolean` value to set its `toggle` boolean value, and `ALTextViewCell` looks for a string value to set its `textView` text value. Some cells, such as `ALCell`, don't even use this value at all.
 */
extern NSString * const ALCellValueKey;                 // input

/**
 *  Use this key to specify the attributed value to be set on the cell.
 *
 *  @discussion Each cell type uses this value differently. In example, `ALTextViewCell` looks for an attributed string value to set its `textView` attributed text value, yet `ALBooleanCell` doesn't consider this value at all. If in doubt, use `ALCellValueKey` to set the value of a cell instead of this key.
 */
extern NSString * const ALCellAttributedValueKey;       // attrInput
