//
//  ALTableViewCellFactoryDelegate.h
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

#import <UIKit/UIKit.h>

/**
 *  `ALTableViewCellFactoryDelegate` defines optional and required methods for a `ALTableViewCellFactory` delegate.
 *
 *  @discussion In addition to these delegate methods, the delegate may implement methods in either `UITableViewDataSource` or `UITableViewDelegate`, and these methods *WILL* be called. *UNLESS* it's one of the following:
 
 *  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    
 *  - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 *
 *  These methods are *exclusively* implemented by `ALTableViewCellFactory` and *won't* be called, even if the delegate implements them.
 */
@protocol ALTableViewCellFactoryDelegate <NSObject /* UITableViewDataSource, UITableViewDelegate */>
@required

/**
 *  This method is called in order for the delegate to determine the number of rows in the table view and section.
 *
 *  @param tableView The table view to add cells to
 *  @param section   The section to add cells to
 *  @return The number of rows for the section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *  This method is called in order to dequeue/create a cell at the given index path.
 *
 *  @warning This method must *never* return `nil`. If it does, an exception will be thrown at runtime.
 *
 *  @param tableView The table view containing the cell to be dequeued/created
 *  @param indexPath The index path for the cell
 *
 *  @return The identifier for the cell at the given index path
 */
- (NSString *)tableView:(UITableView *)tableView identifierForCellAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  This method is called prior to displaying a cell or calculating its height.
 *
 *  @discussion The `ALTableViewCellFactoryDelegate` should set the desired values on the cell within this method.
 *
 *  @param tableView The table view containing the cell
 *  @param cell      The cell to be displayed or calculate the height.
 *  @param indexPath The index path of the cell in the table view
 */
- (void)tableView:(UITableView *)tableView configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  This method allows the delegate to determine the number of sections in the table view.
 *
 *  @discussion If the delegate doesn't implement this method, `1` will be returned.
 *
 *  @param tableView The table view
 *
 *  @return The number of sections in the table view
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

@end
