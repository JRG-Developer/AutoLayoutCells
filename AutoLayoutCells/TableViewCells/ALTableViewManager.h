//
//  ALTableViewManager.h
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
 *  `ALTableViewManager` is an abstract, base class meant to act as the data source and delegate for a table view.
 *
 *  @discussion  Concrete subclasses should set `viewModelArrays` to an array of array ("2D array") of `ALCellViewModel` objects. Subclasses should also override `registerCells` to register table view cells by class/nib to be dequeued.
 */
@interface ALTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 *  The estimated row height for table view cells
 *
 *  @discussion  Subclasses should either set this to a value greater than zero or implement `tableView:estimatedHeightForRowAtIndexPath:`.
 */
@property (assign, nonatomic, readonly) CGFloat estimatedRowHeight;

/**
 *  The table view to provide the data source and delegate
 */
@property (strong, nonatomic, readonly) UITableView *tableView;

/**
 *  This should be set to an array of arrays containing `ALCellViewModel` objects.
 */
@property (strong, nonatomic) NSArray *viewModelArrays;

/**
 *  Use this method to initialize a new `ALTableViewManager`.
 *
 *  @param tableView The table view to provide the data source and delegate
 *  @param estimatedRowHeight  The estimatedRowHeight
 *
 *  @return A new `ALTableViewManager` instance
 */
- (instancetype)initWithTableView:(UITableView *)tableView
               estimatedRowHeight:(CGFloat)estimatedRowHeight NS_DESIGNATED_INITIALIZER;

/**
 *  This is an abstract method meant to be override by subclasses.
 *
 *  @discussion  By default, this method is empty. Subclasses should override this method to register cells on `self.tableView`.
 *
 *  This method is called right after the `tableView` has been set.
 */
- (void)registerCells;

@end
