//
//  ALTableView.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/5/14.
//
//

#import "ALTableView.h"

@implementation ALTableView

#pragma mark - Object Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
  self = [super initWithFrame:frame style:style];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [self reloadData];
  });
}

@end
