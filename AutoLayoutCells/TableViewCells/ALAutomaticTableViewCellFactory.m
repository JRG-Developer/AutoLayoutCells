//
//  ALAutomaticTableViewCellFactory.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 4/25/16.
//
//

#import "ALAutomaticTableViewCellFactory.h"

#import "ALTableViewCellFactoryDelegate.h"
#import "ALBaseCell.h"

@interface ALAutomaticTableViewCellFactory()
@property (strong, nonatomic) NSMutableDictionary *identifiersToNibsDictionary;
@end

@implementation ALAutomaticTableViewCellFactory

#pragma mark - Object Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView identifiersToNibsDictionary:(NSDictionary *)dictionary
{
  self = [super init];
  if (!self) {
    return nil;
  }
  
  _tableView = tableView;
  _tableView.delegate = self;
  _tableView.dataSource = self;
  _tableView.rowHeight = UITableViewAutomaticDimension;
  
  _sizingCellDict = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
  _identifiersToNibsDictionary = [dictionary mutableCopy];
  
  [self registerCellsFromDictionary:dictionary];
  
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
  if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
    return [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
  }
  
  NSString *identifier = [self.delegate tableView:self.tableView identifierForCellAtIndexPath:indexPath];
  return [self cellHeightForIdentifier:identifier atIndexPath:indexPath];
}

- (CGFloat)cellHeightForIdentifier:(NSString *)identifier atIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *sizingCell = [self sizingCellForIdentifier:identifier];
  return CGRectGetHeight(sizingCell.frame);
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

@end
