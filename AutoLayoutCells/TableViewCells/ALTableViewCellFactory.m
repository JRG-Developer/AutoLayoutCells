//
//  ALTableViewCellFactory.m
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

#import "ALTableViewCellFactory.h"
#import "ALTableViewCellFactoryDelegate.h"

#import "ALBaseCell.h"

const CGFloat kAccessoryTypeTrailingMarginWidth = 10.0f;
const CGFloat kAccessoryViewTrailingMarginWidth = 15.0f;
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ALTableViewCellFactory ()
@property (weak, nonatomic, readwrite) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *identifiersToNibsDictionary;
@end

@implementation ALTableViewCellFactory

#pragma mark - Object Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView
      identifiersToNibsDictionary:(NSDictionary *)dictionary
{
  self = [super init];
  if (self) {
    
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _sizingCellDict = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
    _identifiersToNibsDictionary = [dictionary mutableCopy];
    [self registerCellsFromDictionary:dictionary];
    
    _cellSeparatorHeight = 1.0f;
  }
  return self;
}

- (void)registerCellsFromDictionary:(NSDictionary *)dict
{
  [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, UINib *nib, BOOL *stop) {
    [self.tableView registerNib:nib forCellReuseIdentifier:key];
  }];
}

#pragma mark - NSObject

- (BOOL)respondsToSelector:(SEL)selector
{
  if ([self.delegate respondsToSelector:selector]) {
    return YES;
  }
  
  return [super respondsToSelector:selector];
}

- (id)forwardingTargetForSelector:(SEL)selector
{
  if ([self.delegate respondsToSelector:selector]) {
    return self.delegate;
  }
  
  return [super forwardingTargetForSelector:selector];
}

#pragma mark - Custom Accessors

- (void)setDelegate:(id<ALTableViewCellFactoryDelegate>)delegate
{
  if (_delegate == delegate) {
    return;
  }
  
  _delegate = delegate;
  
  //  The table view's data source and delegates have to be reset so that the `respondsToSelector` methods will be called again
  //  `UITableView` must be caching the response from its `dataSource` and `delegate` calls to `respondsToSelector`
  _tableView.dataSource = nil;
  _tableView.delegate = nil;
  
  _tableView.dataSource = self;
  _tableView.delegate = self;
}

#pragma mark - Cell Factory Methods

- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  [self.delegate tableView:self.tableView configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (CGFloat)cellHeightForIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *sizingCell = [self sizingCellForIdentifier:identifier];
  [self.delegate tableView:self.tableView configureCell:sizingCell atIndexPath:indexPath];
  return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (UITableViewCell *)sizingCellForIdentifier:(NSString *)identifier
{
  UITableViewCell *sizingCell = self.sizingCellDict[identifier];
  
  if (!sizingCell) {
    sizingCell = [self makeSizingCellForIdentifier:identifier];
    self.sizingCellDict[identifier] = sizingCell;
  }
  
  return sizingCell;
}

- (UITableViewCell *)makeSizingCellForIdentifier:(NSString *)identifier
{
  UINib *nib = self.identifiersToNibsDictionary[identifier];
  id cell = nil;
  
  if (!nib) {
    cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
  } else {
    cell = [[nib instantiateWithOwner:self options:nil] lastObject];
  }
  
  if ([cell respondsToSelector:@selector(setIsSizingCell:)]) {
    [cell setIsSizingCell:YES];
  }
  
  return cell;
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell
{
  sizingCell.bounds = CGRectMake(0.0f, 0.0f,
                                 [self widthForSizingCell:sizingCell],
                                 CGRectGetHeight(sizingCell.bounds));
  
  [sizingCell setNeedsLayout];
  [sizingCell layoutIfNeeded];
  
  CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  return size.height + self.cellSeparatorHeight;
}

- (CGFloat)widthForSizingCell:(UITableViewCell *)sizingCell
{
  CGFloat width = CGRectGetWidth(self.tableView.bounds);
  
  if(IS_OS_8_OR_LATER) {
    width = [self adjustWidth:width forAccessoryViewOnSizingCell:sizingCell];
  }
  
  return width;
}

- (CGFloat)adjustWidth:(CGFloat)width forAccessoryViewOnSizingCell:(UITableViewCell *)sizingCell
{
  if (sizingCell.accessoryView) {
    width -= kAccessoryViewTrailingMarginWidth;
    
  } else if (sizingCell.accessoryType != UITableViewCellAccessoryNone) {
    width -= kAccessoryTypeTrailingMarginWidth;
    
  }
  
  return width;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if ([self.delegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
    return [self.delegate numberOfSectionsInTableView:tableView];
  }
  
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.delegate tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = [self.delegate tableView:tableView identifierForCellAtIndexPath:indexPath];
  return [self cellWithIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = [self.delegate tableView:self.tableView identifierForCellAtIndexPath:indexPath];
  return [self cellHeightForIdentifier:identifier atIndexPath:indexPath];
}

@end
