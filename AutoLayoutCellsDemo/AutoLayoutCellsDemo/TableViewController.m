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

#import "Model+ALCellAdapter.h"
#import "TextCellModel+ALCellAdapter.h"

static NSString *CellIdentifier = @"ALDemoCell";
static NSString *TextFieldCellIdentifier = @"ALTextFieldCell";
static NSString *TextFieldOnlyCellIdentifier = @"ALTextFieldOnlyCell";
static NSString *TextViewCellIdentifier = @"ALTextViewCell";
static NSString *TextViewOnlyCellIdentifier = @"ALTextViewOnlyCell";

@interface TableViewController()
@property (strong, nonatomic) ALTableViewCellFactory *cellFactory;
@end

@implementation TableViewController

#pragma mark - Object Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit
{
  [self setUpBasicModelsArray];
  [self setUpTextCellModelsArray];
}

- (void)setUpBasicModelsArray
{
  NSArray *modelDictionaries = [self modelsDictionariesFromPlistName:@"ModelsData" bundle:[NSBundle mainBundle]];
  NSMutableArray *models = [NSMutableArray arrayWithCapacity:modelDictionaries.count];
  
  [modelDictionaries enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
    models[idx] = [Model modelFromDictionary:dictionary];
  }];
  
  self.modelsArray = models;
}

- (void)setUpTextCellModelsArray
{
  NSArray *modelDictionaries = [self modelsDictionariesFromPlistName:@"TextCellModelsData" bundle:[NSBundle mainBundle]];
  NSMutableArray *models = [NSMutableArray arrayWithCapacity:modelDictionaries.count];
  
  [modelDictionaries enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
    models[idx] = [TextCellModel modelFromDictionary:dictionary];
  }];
  
  self.textCellModelsArray = models;
}

- (NSArray *)modelsDictionariesFromPlistName:(NSString *)name bundle:(NSBundle *)bundle
{
  NSString *path = [bundle pathForResource:name ofType:@"plist"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSArray *modelDictionaries = [NSPropertyListSerialization propertyListWithData:data
                                                                         options:NSPropertyListImmutable
                                                                          format:nil
                                                                           error:nil];
  return modelDictionaries;
}

#pragma mark - Actions

- (IBAction)refreshButtonPressed:(id)sender
{
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
  NSDictionary *dict = [self identifiersToNibsDictionary];

  self.cellFactory = [[ALTableViewCellFactory alloc] initWithTableView:self.tableView
                                           identifiersToNibsDictionary:dict];
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

- (void)configureCell:(ALBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  Model *model = [self modelForIndexPath:indexPath];
  NSDictionary *dictionary = [model valuesDictionary];
  [cell setValuesFromDictionary:dictionary];
  cell.delegate = self;
}

- (Model *)modelForIndexPath:(NSIndexPath *)indexPath
{
  return indexPath.section == 0 ? self.modelsArray[indexPath.row] :
                                  self.textCellModelsArray[indexPath.row];
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
  TextCellModel *model = self.textCellModelsArray[indexPath.row];
  model.textFieldValue = value;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return section == 0 ? self.modelsArray.count : self.textCellModelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = [self cellIdentifierForRowAtIndexPath:indexPath];
  return [self.cellFactory cellWithIdentifier:identifier forIndexPath:indexPath];
}

- (NSString *)cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath
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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = [self cellIdentifierForRowAtIndexPath:indexPath];
  return [self.cellFactory cellHeightForIdentifier:identifier atIndexPath:indexPath];
}

@end
