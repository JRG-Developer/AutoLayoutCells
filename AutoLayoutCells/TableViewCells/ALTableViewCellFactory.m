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

@interface ALTableViewCellFactory ()
@property (strong, nonatomic) NSDictionary *identifiersToNibsDictionary;
@end

@implementation ALTableViewCellFactory

#pragma mark - Object Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView identifiersToNibsDictionary:(NSDictionary *)dict
{
  self = [super init];
  if (self) {
    _tableView = tableView;
    _sizingCellDict = [NSMutableDictionary dictionaryWithCapacity:dict.count];
    _identifiersToNibsDictionary = dict;
    [self registerCellsFromDictionary:dict];
  }
  return self;
}

- (void)registerCellsFromDictionary:(NSDictionary *)dict
{
  [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, UINib *nib, BOOL *stop) {
    [self.tableView registerNib:nib forCellReuseIdentifier:key];
  }];
}

#pragma mark - Cell Factory Methods

- (UITableViewCell *)cellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self findCellWithIdentifier:identifier forIndexPath:indexPath];
  [self.delegate configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (UITableViewCell *)findCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
  return [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (CGFloat)cellHeightForIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *sizingCell = [self sizingCellForIdentifier:identifier];
  [self.delegate configureCell:sizingCell atIndexPath:indexPath];
  return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (UITableViewCell *)sizingCellForIdentifier:(NSString *)identifier
{
  ALBaseCell *sizingCell = self.sizingCellDict[identifier];
  
  if (sizingCell == nil) {
    sizingCell = [self makeSizingCellForIdentifier:identifier];
    self.sizingCellDict[identifier] = sizingCell;
  }
  
  return sizingCell;
}

- (ALBaseCell *)makeSizingCellForIdentifier:(NSString *)identifier
{
  UINib *nib = self.identifiersToNibsDictionary[identifier];
  ALBaseCell *cell = [[nib instantiateWithOwner:self options:nil] lastObject];
  [cell setIsSizingCell:YES];
  return cell;
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell
{
  sizingCell.bounds = CGRectMake(0.0f, 0.0f,
                                 CGRectGetWidth(self.tableView.bounds),
                                 CGRectGetHeight(sizingCell.bounds));
  
  [sizingCell setNeedsLayout];
  [sizingCell layoutIfNeeded];
  
  CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  return size.height;
}

@end
