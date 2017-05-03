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

#import "ALAutomaticTableViewCellFactory.h"
#import "ALSystemVersionDefines.h"
#import "ALTableViewCellFactory.h"

@implementation ALTableViewManager

#pragma mark - Object Lifecycle

- (instancetype)init
{
  return [super init];
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
  NSParameterAssert(tableView);
  
  self = [super init];
  if (!self) {
    return nil;
  }
  
  [self setTableView:tableView];
  return self;
}

#pragma mark - Custom Accessors

- (void)setTableView:(UITableView *)tableView
{
  if (_tableView == tableView) {
    return;
  }
  
  _tableView = tableView;
  
  [self setupCellFactory];
  
  [self configureTableView];
  [self registerCells];
}

- (void)setupCellFactory {
    
    if (AL_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        _cellFactory = [[ALAutomaticTableViewCellFactory alloc] initWithTableView:_tableView
                                                      identifiersToNibsDictionary:@{}];
        
    } else {
      
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        _cellFactory = [[ALTableViewCellFactory alloc] initWithTableView:_tableView
                                             identifiersToNibsDictionary:@{}];
#pragma GCC diagnostic pop
    }
    
    _cellFactory.delegate = self;
}

- (void)configureTableView
{
  // Empty by default
}

- (void)registerCells
{
  // Empty by default
}

- (void)reloadViewModels
{
  // Empty by default
}

- (void)setViewModelArrays:(NSArray<NSArray<id <ALCellViewModel>> *> *)viewModelArrays
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

#pragma mark - ALTableViewCellFactoryDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.viewModelArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSArray *rows = self.viewModelArrays[section];
  return rows.count;
}

- (NSString *)tableView:(UITableView *)tableView identifierForCellAtIndexPath:(NSIndexPath *)indexPath
{
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  return [viewModel cellIdentifier];
}

- (void)tableView:(UITableView *)tableView configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath
{
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  [viewModel configureCell:cell];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id cell = [tableView cellForRowAtIndexPath:indexPath];
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  [viewModel didSelectCell:cell];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  return [[viewModel editActionsForCell] count] > 0;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id <ALCellViewModel> viewModel = [self viewModelForIndexPath:indexPath];
  return [viewModel editActionsForCell];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{  
  // Empty by default; required to use UITableViewRowActions
}

@end
