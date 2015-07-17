//
//  ALCellViewModel.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 7/13/15.
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

#import <UIKit/UIKit.h>

/**
 *  `ALCellViewModel` objects are used by `ALTableViewManager` to create and dequeue table view cells.
 *
 *  @discussion  `ALCellViewModel` should map
 */
@protocol ALCellViewModel <NSObject>

@required

/**
 *  This method should return the identifier for the cell associated with the view model.
 *
 *  @return The identifier for the cell associated with the view model.
 */
- (NSString *)cellIdentifier;

/**
 *  This method should configure the cell associated with the view model.
 *
 *  @param cell The cell to be configured
 */
- (void)configureCell:(id)cell;

/**
 *  This method is called whenever the cell associated with the view model is selected.
 */
- (void)didSelectCell;

/**
 *  This method should return an array of `UITableViewRowAction` objects for the cell associated with the view model.
 *
 *  @return An array of `UITableViewRowAction` objects
 */
- (NSArray *)editActionsForCell;

@end
