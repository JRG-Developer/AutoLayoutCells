//
//  ALTableViewCellFactory.h
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

#import "ALTableViewCellFactoryProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  `ALTableViewCellFactory` encapsulates common cell creation/dequeuing and cell height calculation tasks.
 *
 *  @deprecated as of iOS 8.0. Use `ALAutomaticTableViewCellFactory` instead.
 */
@interface ALTableViewCellFactory : NSObject <ALTableViewCellFactoryProtocol>

/**
 *  The delegate that performs cell configuration
 *  @see `ALTableViewCellFactoryDelegate` for more details
 */
@property (weak, nonatomic, nullable) id<ALTableViewCellFactoryDelegate> delegate;

/**
 *  The table view that displays the cells
 */
@property (weak, nonatomic, readonly, nullable) UITableView *tableView;

/**
 *  A dictionary of sizing cells (keys are cell identifiers, values are sizing cells)
 */
@property (nonatomic, strong) NSMutableDictionary *sizingCellDict;

/**
 *  The height of the cell separator, defaults to `1.0f`.
 *
 *  @discussion This height is added to the height determined from `systemLayoutSizeFittingSize` called on the cell's `contentView` to determine the overall height estimate for the cell.
 *
 *  @see `cellHeightForIdentifier:atIndexPath` method implementation
 */
@property (assign, nonatomic) CGFloat cellSeparatorHeight;

/**
 *  This is the designated initializer
 *
 *  @param tableView The table view to use for displaying/dequeuing cells.
 *  @param dictionary A dictionary with cell identifiers as keys and cell nibs as values
 *
 *  @return A new `ALTableViewCellFactory` instance
 */
- (instancetype)initWithTableView:(UITableView *)tableView
      identifiersToNibsDictionary:(NSDictionary *)dictionary
      __attribute__((deprecated("ALTableViewCellFactory is deprecated as of iOS 8.0.")));

@end

@interface ALTableViewCellFactory (Protected)

/**
*  This method is called within `tableView:cellForRowAtIndexPath:`
*
*  @discussion This method asks the delegate for `tableView:identifierForCellAtIndexPath:` to create/dequeue the cell.
*
*  @param identifier The cell identifier
*  @param indexPath  The index path for the cell
*
*  @return A configured `UITableViewCell`
*/
- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/**
 *  This is called within `tableView:heightForRowAtIndexPath:`
 *
 *  @discussion This method asks the delegate for `tableView:identifierForCellAtIndexPath:` to create/dequeue the sizing cell.
 *
 *  @param identifier The cell identifier
 *  @param indexPath  The index path for the cell
 *
 *  @return The height of the configured cell at the index path (based on a sizing cell)
 */
- (CGFloat)cellHeightForIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath;

/**
 *  This method is called to get the "sizingCell" from the `sizingCellDictionary` for the given cell identifier. If a sizing cell doesn't already exist within the `sizingCellDictionary`, one will be created and inserted into the dictionary.
 *
 *  @param identifier The cell identifier
 *
 *  @return The `sizingCell` for the given cell identifier.
 */
- (UITableViewCell *)sizingCellForIdentifier:(NSString *)identifier;

/**
 *  This method is called to calculate the width of the "sizingCell" for use in height caluculations in `cellHeightForIdentifier:atIndexPath:`.
 *
 *  @param sizingCell The sizing cell to calculate the width for.
 *
 *  @return The width for the configured `sizingCell`
 */
- (CGFloat)widthForSizingCell:(UITableViewCell *)sizingCell;

/**
 *  This is called in `widthForSizingCell:` to determine if the cell's width should be adjusted for an accessory view.
 *
 *  @return A boolean indicating if the device is runnning an iOS version of 8.0 or later.
 */
- (BOOL)isOS8OrLater;

@end

NS_ASSUME_NONNULL_END
