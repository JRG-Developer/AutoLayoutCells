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

NS_ASSUME_NONNULL_BEGIN

/**
 *  `ALSimpleCellViewModel` is a very simple, block-based implementation of `ALCellViewModel`.
 *
 *  @discussion  This simple view-model should be sufficient for many use cases.
 *
 *  It's recommended that you first try to use this simple view-model, until you determine that more complex logic is required to fullfill your specific needs.
 */
@interface ALSimpleCellViewModel : NSObject <ALCellViewModel>

#pragma mark - Instance Properties

/**
 *  The cell identifier
 */
@property (copy, nonatomic, readonly) NSString *cellIdentifier;

/**
 *  The block to be called in response to `configureCell:` method call
 */
@property (strong, nonatomic, nullable) void (^configureCellBlock)(id cell);

/**
 *  The block to be called in response to `didSelectCell` method call
 */
@property (strong, nonatomic, nullable) void (^didSelectCellBlock)(id cell);

/**
 *  The edit actions for the cell
 */
@property (strong, nonatomic, nullable) NSArray<UITableViewRowAction *> *editActionsForCell;

#pragma mark - Object Lifecycle

/**
 *  @brief  This is the preferred way to create an `ALSimpleCellViewModel`.
 *
 *  @param cellIdentifier The cell identifier
 *
 *  @return A new `ALSimpleCellViewModel` instance
 */
- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
