//
//  ALTextCellViewModel.h
//  AutoLayoutCells
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

#import "ALTextCellViewModel.h"

#import "ALTextFieldCell.h"
#import "ALTextFieldOnlyCell.h"
#import "ALTextViewCell.h"
#import "ALTextViewOnlyCell.h"

#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

@implementation ALTextCellViewModel

#pragma mark - Object Lifecycle

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
  return [self initWithCellIdentifier:cellIdentifier tableView:nil];
}

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
                             tableView:(UITableView *)tableView {
  
  self = [super initWithCellIdentifier:cellIdentifier];
  if (!self) {
    return nil;
  }
  
  _tableView = tableView;

  return self;
}

- (void)configureCell:(id)tableViewCell {
  
  if ([tableViewCell isKindOfClass:[ALTextViewCell class]]) {
    ALTextViewCell *cell = (ALTextViewCell *)tableViewCell;
    cell.heightDelegate = self;
  }
  
  [super configureCell:tableViewCell];
}

#pragma mark - ALCellViewModel

- (void)didSelectCell:(id)tableViewCell {
  
  if (self.didSelectCellBlock) {
    self.didSelectCellBlock(tableViewCell);
  }
  
  if ([(ALBaseCell *)tableViewCell isViewOnly]) {
    return;
  }
  
  if ([tableViewCell isKindOfClass:[ALTextViewCell class]]) {
    ALTextViewCell *cell = tableViewCell;
    [cell.textView becomeFirstResponder];
    
  } else if ([tableViewCell isKindOfClass:[ALTextFieldCell class]]) {
    ALTextFieldCell *cell = tableViewCell;
    [cell.textField becomeFirstResponder];
    
  } else if ([tableViewCell isKindOfClass:[ALTextViewOnlyCell class]]) {
    ALTextViewOnlyCell *cell = tableViewCell;
    [cell.textView becomeFirstResponder];
    
  } else if ([tableViewCell isKindOfClass:[ALTextFieldOnlyCell class]]) {
    ALTextFieldOnlyCell *cell = tableViewCell;
    [cell.textField becomeFirstResponder];
  }
}

#pragma mark - ALTextCellDelegate

- (void)cellHeightWillChange:(ALTextViewCell *)cell delta:(CGFloat)delta {
  NSParameterAssert(self.tableView);
  
  [UIView setAnimationsEnabled:NO];
  [self.tableView beginUpdates];
}

- (void)cellHeightDidChange:(ALTextViewCell *)cell delta:(CGFloat)delta {
  
  NSParameterAssert(self.tableView);
  
  [self.tableView endUpdates];
  [UIView setAnimationsEnabled:YES];
}

@end
