//
//  ALCustomCellFactoryTests.m
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

// Test Class
#import "ALTableViewCellFactory.h"

// Collaborators
#import "ALCell.h"
#import "ALLeftLabelCell.h"
#import "ALTableViewCellFactoryDelegate.h"
#import "Test_ALTableViewCellNibFactory.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTableViewCellFactoryTests : XCTestCase
@end

@implementation ALTableViewCellFactoryTests
{
  ALTableViewCellFactory *sut;
  id delegate;
  id tableView;
  
  NSString *cellIdentifer;
  NSString *leftCellIdentifier;
  
  UINib *cellNib;
  UINib *leftLabelCellNib;
  
  NSDictionary *identifierToNibsDict;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  sut = [[ALTableViewCellFactory alloc] initWithTableView:[self mockTableView]
                           identifiersToNibsDictionary:[self identifierToNibsDictionary]];
  
  sut.delegate = [self mockDelegate];
}

- (UITableView *)mockTableView
{
  UINib *nib = [Test_ALTableViewCellNibFactory cellWithName:@"ALCell" owner:self];
  tableView = OCMClassMock([UITableView class]);
  OCMStub([tableView dequeueReusableCellWithIdentifier:[OCMArg any]]).andReturn(nib);
  
  return tableView;
}

- (id <ALTableViewCellFactoryDelegate>)mockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALTableViewCellFactoryDelegate));
  return delegate;
}

- (NSDictionary *)identifierToNibsDictionary
{
  [self setUpIdentifiers];
  [self setUpNibs];
  
  identifierToNibsDict = @{cellIdentifer: cellNib,
                           leftCellIdentifier: leftLabelCellNib};
  
  return identifierToNibsDict;
}

- (void)setUpIdentifiers
{
  cellIdentifer = @"ALCellIdentifier";
  leftCellIdentifier = @"ALLeftCellIdentifier";
}

- (void)setUpNibs
{
  cellNib = [UINib nibWithNibName:@"ALCell" bundle:[NSBundle mainBundle]];
  leftLabelCellNib = [UINib nibWithNibName:@"ALLeftLabelCell" bundle:[NSBundle mainBundle]];
}

#pragma mark - Register Cells - Tests

- (void)test_initWithTableView_identifiersToNibsDictionary_registersNibDictionary
{
  expect(tableView).toNot.beNil();
  expect(sut.tableView).to.equal(tableView);
  
  [[tableView verify] registerNib:cellNib forCellReuseIdentifier:cellIdentifer];
  [[tableView verify] registerNib:leftLabelCellNib forCellReuseIdentifier:leftCellIdentifier];
}

#pragma mark - Dequeuing Cells - Tests

- (void)test_cellWithIdentifier_cellIdentifier_dequeuesCellWithIdentifier_cellIdentifier
{
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [sut cellWithIdentifier:cellIdentifer forIndexPath:indexPath];
  
  [[tableView verify] dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
}

- (void)test_cellWithIdentifier_leftLabelCellIdentifier_dequeuesCellWithIdentifier_leftLabelCellIdentifier
{
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [sut cellWithIdentifier:leftCellIdentifier forIndexPath:indexPath];
  
  [[tableView verify] dequeueReusableCellWithIdentifier:leftCellIdentifier forIndexPath:indexPath];
}

- (void)test_cellWithIdentifierAtIndexPath_configuresCellFromDelegate
{
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  id cell = [sut cellWithIdentifier:cellIdentifer forIndexPath:indexPath];
  
  [[delegate verify] configureCell:cell atIndexPath:indexPath];
}

#pragma mark - Cell Sizing - Tests

- (void)test_heightForCellWithIdentifier_cellIdentifier_configuresCellFromDelegate
{
  // given
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  id cell = [sut sizingCellForIdentifier:cellIdentifer];

  // when
  [sut cellHeightForIdentifier:cellIdentifer atIndexPath:indexPath];
  
  // then
  [[delegate verify] configureCell:cell atIndexPath:indexPath];
}

@end
