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

@protocol ALCellViewModel <NSObject>

/**
 *  @brief  This method should return a `UITableViewCell` for the given `tableView` at the `indexPath`.
 *
 *  @discussion  While you can return any `UITableViewCell` instance/subclass, it's recommended that you return a subclass of `ALBaseCell` with a `valueDidChangeBlock` and other desired blocks set.
 *
 *  @param tableView The table view to dequeue the cell for
 *  @param indexPath The index path for the cell to be dequeued
 *
 *  @return A `UITableViewCell` for the given `tableView` at the `indexPath`
 */
- (id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
