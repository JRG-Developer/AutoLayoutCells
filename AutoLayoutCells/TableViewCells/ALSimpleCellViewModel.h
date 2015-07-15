//
//  ALSimpleCellViewModel.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 7/14/15.
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

#import "ALCellViewModel.h"

/**
 *  `ALSimpleCellViewModel` is a very simple, block-based implementation of `ALCellViewModel`.
 *
 *  @discussion  This simple view-model should be sufficient for many use cases.
 *
 *  It's recommended that you first try to use this simple view-model, until you determine that more complex logic is required to fullfill your specific needs.
 */
@interface ALSimpleCellViewModel : NSObject <ALCellViewModel>

/**
 *  The model backing the view model
 */
@property (strong, nonatomic) id model;

/**
 *  The block to be called in response to `cellForTableView:` method call
 */
@property (strong, nonatomic) UITableViewCell * (^cellForTableViewBlock)(UITableView *);

/**
 *  The block to be called in response to `didSelectCell` method call
 */
@property (strong, nonatomic) void (^didSelectCellBlock)();

/**
 *  The edit actions for the cell
 */
@property (strong, nonatomic) NSArray *editActionsForCell;

/**
 *  This is the preferred way to instantiate an `ALSimpleCellViewModel` object.
 *
 *  @warning  `cellForTableViewBlock` is REQUIRED and MUST return a `UITableViewCell`. Otherwise, an assert will be failed at runtime.
 *
 *  @param model                 The associated model
 *  @param cellForTableViewBlock The block to be called in response to `cellForTableView:` method call, REQUIRED
 *  @param didSelectCellBlock    The block to be called in response to `didSelectCell` method call
 *  @param editActionsForCell    The edit actions for the cell
 *
 *  @return A new `ALSimpleCellViewModel` instance
 */
- (instancetype)initWithModel:(id)model
        cellForTableViewBlock:(UITableViewCell * (^)(UITableView *tableView))cellForTableViewBlock
           didSelectCellBlock:(void(^)())didSelectCellBlock
           editActionsForCell:(NSArray *)editActionsForCell NS_DESIGNATED_INITIALIZER;

@end
