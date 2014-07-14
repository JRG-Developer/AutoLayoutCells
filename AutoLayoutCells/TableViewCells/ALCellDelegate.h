//
//  ALCellDelegate.h
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

#import <Foundation/Foundation.h>

/**
 *  `ALCellDelegate` includes optional methods to notify the delegate of cell value-related events.
 */
@protocol ALCellDelegate <NSObject>
@optional

/**
 *  This method is called whenever a user did begin editing a cell's value.
 *
 *  @note Not all cell types will call this method. In general, text-input cells (e.g. `ALTextCell` and `ALTextOnlyCell`) will call this method if their delegate implements it.
 *
 *  @param cell The cell whose value will begin editing
 */
- (void)cellWillBeginEditing:(id)cell;

/**
 *  This method is called whenever a cell's value has changed.
 *
 *  @note It's expected that the controller should know the type of value based on the cell.
 *
 *  @param cell  The cell whose value has changed
 *  @param value The new cell value
 */
- (void)cell:(id)cell valueChanged:(id)value;

/**
 *  This method is called whenever a user did end editing a cell's value.
 *
 *  @note Not all cell types will call this method. In general, text-input cells (e.g. `ALTextCell` and `ALTextOnlyCell`) will call this method if their delegate implements it.
 *
 *  @note It's expected that the controller should know the type of value based on the cell.
 *
 *  @param cell  The cell whose value did end editing
 *  @param value The new value for the cell
 */
- (void)cell:(id)cell didEndEditing:(id)value;

@end
