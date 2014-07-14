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

@import UIKit;

@protocol ALTableViewCellFactoryDelegate;

/**
 *  `ALTableViewCellFactory` encapsulates common cell creation and height calculation tasks.
 */
@interface ALTableViewCellFactory : NSObject

/**
 *  The delegate that performs cell configuration
 *  @see `ALTableViewCellFactoryDelegate` for more details
 */
@property (nonatomic, weak) id<ALTableViewCellFactoryDelegate> delegate;

/**
 *  The table view that displays all of the cells
 */
@property (nonatomic, weak) UITableView *tableView;

/**
 *  A dictionary of sizing cells (keys are cell identifiers, values are sizing cells)
 */
@property (nonatomic, strong) NSMutableDictionary *sizingCellDict;

/**
 *  This is the designated initializer
 *
 *  @param tableView The table view that will display all of the cells
 *  @param dictionary A dictionary with cell identifiers as keys and cell nibs as values
 *
 *  @return A new `ALTableViewCellFactory` instance
 */
- (instancetype)initWithTableView:(UITableView *)tableView identifiersToNibsDictionary:(NSDictionary *)dictionary;

/**
 *  This method should be called within `tableView:cellForRowAtIndexPath:`
 *
 *  @param identifier The cell identifier
 *  @param indexPath  The index path for the cell
 *
 *  @return A configured `UITableViewCell`
 */
- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/**
 *  This method should be called within `tableView:heightForRowAtIndexPath:`
 *
 *  @param identifier The cell identifier
 *  @param indexPath  The index path for the cell
 *
 *  @return The height of the configured cell at the index path (based on a sizing cell)
 */
- (CGFloat)cellHeightForIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath;
@end

/**
 *  These methods should be considered "protected" and should only be called by this class/subclasses.
 */
@interface ALTableViewCellFactory (Protected)

/**
 *  This method is called to get the "sizingCell" from the `sizingCellDictionary` for the given cell identifier. If a sizing cell doesn't already exist within the `sizingCellDictionary`, one will be created and inserted into the dictionary.
 *
 *  @param identifier The cell identifier
 *
 *  @return The `sizingCell` for the given cell identifier.
 */
- (UITableViewCell *)sizingCellForIdentifier:(NSString *)identifier;

@end
