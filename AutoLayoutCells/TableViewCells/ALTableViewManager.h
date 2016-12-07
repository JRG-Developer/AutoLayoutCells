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

#import "ALCellViewModel.h"
#import "ALTableViewCellFactoryDelegate.h"

@protocol ALTableViewCellFactoryProtocol;


NS_ASSUME_NONNULL_BEGIN

/**
 *  `ALTableViewManager` is an abstract, base class meant to act as the data source and delegate for a table view.
 *
 *  @discussion  Concrete subclasses should set `viewModelArrays` to an array of arrays ("2D array") of `ALCellViewModel` objects. 
 *
 *  Subclasses should also override `registerCells` to register table view cells by class/nib to be dequeued.
 */
@interface ALTableViewManager : NSObject <ALTableViewCellFactoryDelegate, UITableViewDelegate>

/**
 *  The table view cell factory is responsible for creating/dequeuing cells and calculating cell height.
 *
 *  @discussion  If prior to iOS 8, this is set to `ALTableViewCellFactory`. Otherwise, it's set to `ALAutomaticTableViewCellFactory`.
 */
@property (strong, nonatomic, readonly) id<ALTableViewCellFactoryProtocol> cellFactory;

/**
 *  The table view to be managed
 */
@property (strong, nonatomic, nullable) UITableView *tableView;

/**
 *  This should be set to an array of arrays containing `ALCellViewModel` objects.
 */
@property (strong, nonatomic) NSArray<NSArray<ALCellViewModel> *> *viewModelArrays;

/**
 *  Use this method to initialize a new `ALTableViewManager` without a `tableView`.
 *
 *  @discussion  In order to do anything useful, you'll need to actually set the `tableView` at some later point (likely, within a view controller's `viewDidLoad` method).
 *
 *  This method is useful, for example, if you need to inject other objects into your custom table view manager prior to a view controller's `viewDidLoad` method.
 *
 *  @return A new `ALTableViewManager` instance
 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 *  Use this method to initialize a new `ALTableViewManager` with a `tableView`.
 *
 *  @discussion  This is useful, for example, if you're creating an `ALTableViewManager` inside a view controller's `viewDidLoad` method.
 *
 *  @param tableView The table view to provide the data source and delegate
 *  @param estimatedRowHeight  The estimatedRowHeight
 *
 *  @return A new `ALTableViewManager` instance
 */
- (instancetype)initWithTableView:(nullable UITableView *)tableView NS_DESIGNATED_INITIALIZER;

/**
 *  This is an abstract method meant to be overriden by subclasses.
 *
 *  @discusion  By default, this method sets the `dataSource`, `delegate`, `estimatedRowHeight` and `rowHeight` on on `self.tableView`. See implementation for more details.
 */
- (void)configureTableView __attribute((objc_requires_super));

/**
 *  This is an abstract method meant to be overriden by subclasses.
 *
 *  @discussion  By default, this method is empty. Subclasses should override this method to register cells on `self.tableView`.
 *
 *  This method is called right after the `tableView` has been set.
 */
- (void)registerCells;

/**
 *  This is an abstract method meant to be override by subclasses.
 *
 *  @discussion  By default, this method is empty. Subclasses should override this method to setup/reload `viewModelArrays`.
 */
- (void)reloadViewModels;

@end

NS_ASSUME_NONNULL_END
