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

#import "Model+ALCellAdapter.h"

static NSString *ALImageCellIdentifier = @"ALImageCellIdentifier";

@interface TableViewController()
@property (strong, nonatomic) ALTableViewCellFactory *cellFactory;
@end

@implementation TableViewController

- (void)setModelsFromPlistName:(NSString *)name bundle:(NSBundle *)bundle
{
  NSString *path = [bundle pathForResource:name ofType:@"plist"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSArray *modelDictionaries = [NSPropertyListSerialization propertyListWithData:data
                                                             options:NSPropertyListImmutable
                                                              format:nil
                                                               error:nil];
  
  NSMutableArray *models = [NSMutableArray arrayWithCapacity:modelDictionaries.count];
  
  [modelDictionaries enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
    models[idx] = [Model modelFromDictionary:dictionary];
  }];
  
  self.modelsArray = models;
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

  self.cellFactory = [[ALTableViewCellFactory alloc] initWithTableView:self.tableView identifiersToNibsDictionary:dict];
  self.cellFactory.delegate = self;
}

- (NSDictionary *)identifiersToNibsDictionary
{
  return @{ALImageCellIdentifier: [ALTableViewCellNibFactory menuCellNib]};
}

#pragma mark - ALTableViewCellFactoryDelegate

- (void)configureCell:(ALImageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  Model *model = self.modelsArray[indexPath.row];
  NSDictionary *dict = [model valuesDictionary];
  [cell setValuesDictionary:dict];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [self.cellFactory cellWithIdentifier:ALImageCellIdentifier forIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [self.cellFactory cellHeightForIdentifier:ALImageCellIdentifier atIndexPath:indexPath];
}

@end
