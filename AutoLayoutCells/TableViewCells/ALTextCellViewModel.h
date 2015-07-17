//
//  TextCellViewModel.h
//  CityScavengerHunt
//
//  Created by Joshua Greene on 7/17/15.
//  Copyright (c) 2015 JRG-Developer. All rights reserved.
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

#import "ALSimpleCellViewModel.h"
#import "ALTextCellDelegate.h"

/**
 *  `ALTextCellViewModel` extends `ALSimpleCellViewModel` to automatically "resize" the text-view cell when the text view's height changes.
 *
 *  @discussion  `ALTextCellViewModel` provides a *very* simple implementation for `ALTextCellDelegate`-- implementing just enough delegate methods to cause the cell to be resized on its text view's height changes.
 *
 *  If you want do do anything more meaningful than this (e.g. implement other delegate methods), you should use your own custom class instead.
 */
@interface ALTextCellViewModel : ALSimpleCellViewModel <ALTextCellDelegate>

/**
 *  "Resizing the cell" is actually done by asking the table view to recalculate cell heights.
 *
 *  For this reason, the table view must be set, or else cell resizing won't actually happen.
 */
@property (weak, nonatomic) UITableView *tableView;

@end
