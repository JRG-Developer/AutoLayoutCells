//
//  ALAutomaticTableViewCellFactory.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 4/25/16.
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

#import "ALTableViewCellFactoryProtocol.h"

/**
 *  @brief  `ALAutomaticTableViewCellFactory` encapsulates cell creation/dequeuing logic and cell height calculation tasts.
 *
 *  @discussion  This class deprecates `ALTableViewCellFactory` for iOS 9.0 and up, where Apple's logic for determining dynamic table view cell heights has greatly improved.
 */

NS_AVAILABLE_IOS(9.0)
@interface ALAutomaticTableViewCellFactory : NSObject <ALTableViewCellFactoryProtocol>

/**
 *  The delegate that performs cell configuration
 *  @see `ALTableViewCellFactoryDelegate` for more details
 */
@property (weak, nonatomic) id<ALTableViewCellFactoryDelegate> delegate;

/**
 *  The table view that displays the cells
 */
@property (weak, nonatomic, readonly) UITableView *tableView;

/**
 *  A dictionary of sizing cells (keys are cell identifiers, values are sizing cells).
 *
 *  @note  These are _only_ used if you the delegate doesn't implement `tableView: estimatedHeightForRowAtIndexPath:`.
 */
@property (nonatomic, strong) NSMutableDictionary *sizingCellDict;

/**
 *  This is the designated initializer
 *
 *  @param tableView The table view to use for displaying/dequeuing cells.
 *  @param dictionary A dictionary with cell identifiers as keys and cell nibs as values
 *
 *  @return A new `ALTableViewCellFactory` instance
 */
- (instancetype)initWithTableView:(UITableView *)tableView identifiersToNibsDictionary:(NSDictionary *)dictionary;

@end

@interface ALAutomaticTableViewCellFactory (Protected)

/**
 *  This method is called within `tableView: cellForRowAtIndexPath:`
 *
 *  @discussion This method asks the delegate for `tableView: identifierForCellAtIndexPath:` to create/dequeue the cell.
 *
 *  @param identifier The cell identifier
 *  @param indexPath  The index path for the cell
 *
 *  @return A configured `UITableViewCell`
 */
- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

@end
