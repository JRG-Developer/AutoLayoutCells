//
//  ALTableViewManager.m
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

#import "ALTableViewManager.h"

#import "ALCellViewModel.h"

@interface ALTableViewManager ()
@property (strong, nonatomic, readwrite) UITableView *tableView;
@end

@implementation ALTableViewManager

#pragma mark - Object Lifecycle

- (instancetype)init {
  
  [NSException raise:@"method not supported" format:@"use `initWithTableView: estimatedRowHeight:` instead"];
  return [self initWithTableView:nil estimatedRowHeight:0.0f];
}

- (instancetype)initWithTableView:(UITableView *)tableView
               estimatedRowHeight:(CGFloat)estimatedRowHeight
{
  NSParameterAssert(tableView);
  
  self = [super init];
  if (!self) {
    return nil;
  }
  
  [self setEstimatedRowHeight:estimatedRowHeight];
  [self setTableView:tableView];
  
  return self;
}

#pragma mark - Custom Accessors

- (void)setEstimatedRowHeight:(CGFloat)estimatedRowHeight
{
  if (_estimatedRowHeight == estimatedRowHeight) {
    return;
  }
  
  _estimatedRowHeight = estimatedRowHeight;
  self.tableView.estimatedRowHeight = estimatedRowHeight;
}

- (void)setTableView:(UITableView *)tableView
{
  if (_tableView == tableView) {
    return;
  }
  
  _tableView = tableView;
  _tableView.dataSource = self;
  _tableView.delegate = self;
  
  _tableView.estimatedRowHeight = self.estimatedRowHeight;
  _tableView.rowHeight = UITableViewAutomaticDimension;
  
  [self registerCells];
}

- (void)registerCells
{
  // empty by default
}

- (void)setViewModelArrays:(NSArray *)viewModelArrays
{
  if (_viewModelArrays == viewModelArrays) {
    return;
  }
  
  _viewModelArrays = viewModelArrays;
  [self.tableView reloadData];
}

#pragma mark - Utilities

- (id<ALCellViewModel>)viewModelForIndexPath:(NSIndexPath *)indexPath {

  NSArray *rows = self.viewModelArrays[indexPath.section];
  id <ALCellViewModel> viewModel = rows[indexPath.row];
  return viewModel;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.viewModelArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSArray *rows = self.viewModelArrays[section];
  return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  return [viewModel cellForTableView:tableView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
    [viewModel didSelectCell];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  return [viewModel editActionsForCell];
}

@end
