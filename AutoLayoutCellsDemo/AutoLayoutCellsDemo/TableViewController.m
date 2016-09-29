//
//  ViewController.m
//  AutoLayoutCellsExample
//
//  Created by Joshua Greene on 9/5/14.
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

#import "TableViewController.h"
#import <AutoLayoutCells/AutoLayoutCells.h>
#import <AutoLayoutCells/ALTextFieldCell.h>
#import <AutoLayoutCells/ALTextFieldOnlyCell.h>
#import <AutoLayoutCells/ALTextViewCell.h>
#import <AutoLayoutCells/ALTextViewOnlyCell.h>

#import <AutoLayoutCells/UIImageView+ALImageWithURL.h>
#import <AutoLayoutCells/ALImageCache.h>

#import "Model+ALCellAdapter.h"
#import "TextCellModel+ALCellAdapter.h"

static NSString *CellIdentifier = @"ALDemoCell";
static NSString *TextFieldCellIdentifier = @"ALTextFieldCell";
static NSString *TextFieldOnlyCellIdentifier = @"ALTextFieldOnlyCell";
static NSString *TextViewCellIdentifier = @"ALTextViewCell";
static NSString *TextViewOnlyCellIdentifier = @"ALTextViewOnlyCell";

@interface TableViewController()
@property (strong, nonatomic) ALAutomaticTableViewCellFactory *cellFactory;
@end

@implementation TableViewController

#pragma mark - Actions

- (IBAction)refreshButtonPressed:(id)sender
{
  [[UIImageView AL_sharedImageDownloadCache] removeAllObjects];
  [self.tableView reloadData];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupCellFactory];
}

- (void)setupCellFactory
{
  self.cellFactory = [[ALAutomaticTableViewCellFactory alloc] initWithTableView:self.tableView
                                           identifiersToNibsDictionary:[self identifiersToNibsDictionary]];
  self.cellFactory.delegate = self;
}

- (NSDictionary *)identifiersToNibsDictionary
{
  return @{TextFieldCellIdentifier: [ALTableViewCellNibFactory textFieldCellNib],
           TextFieldOnlyCellIdentifier: [ALTableViewCellNibFactory textFieldOnlyCellNib],
           TextViewCellIdentifier: [ALTableViewCellNibFactory textViewCellNib],
           TextViewOnlyCellIdentifier: [ALTableViewCellNibFactory textViewOnlyCellNib]};
}

#pragma mark - ALTableViewCellFactoryDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return section == 0 ? self.models.count : self.textModels.count;
}

- (NSString *)tableView:(UITableView *)tableView identifierForCellAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 1) {
    
    switch (indexPath.row % 4) {
      case 0: return TextFieldCellIdentifier;
      case 1: return TextFieldOnlyCellIdentifier;
      case 2: return TextViewCellIdentifier;
      case 3: return TextViewOnlyCellIdentifier;
    }
  }
  
  return CellIdentifier;
}

- (void)tableView:(UITableView *)tableView configureCell:(ALCell *)cell atIndexPath:(NSIndexPath *)indexPath;
{
  Model *model = [self modelForIndexPath:indexPath];
  NSDictionary *dictionary = [model valuesDictionary];
  [cell setValuesFromDictionary:dictionary];
  
  [self configureAccessoryViewForCell:cell atIndexPath:indexPath];
}

- (void)configureAccessoryViewForCell:(ALCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 10) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.accessoryView = nil;
    
  } else if (indexPath.row == 11) {
    cell.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 50.0f)];
    cell.accessoryView.backgroundColor = [UIColor redColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
  } else {
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = nil;
  }
}

- (Model *)modelForIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? self.models[indexPath.row] : self.textModels[indexPath.row];
}

#pragma mark - ALTextCellDelegate

- (void)cellHeightDidChange:(id)cell
{
  [self.tableView beginUpdates];
  [self.tableView endUpdates];
}

- (void)cell:(id)cell valueChanged:(id)value
{
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  TextCellModel *model = self.textModels[indexPath.row];
  model.textFieldValue = value;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSLog(@"Selected: %@", indexPath);
}

@end
