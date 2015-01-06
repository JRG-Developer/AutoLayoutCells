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
  
  id partialMock;
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
  UITableViewCell *cell = [Test_ALTableViewCellNibFactory cellWithName:@"ALCell" owner:self];
  tableView = OCMClassMock([UITableView class]);
  OCMStub([tableView dequeueReusableCellWithIdentifier:[OCMArg any]]).andReturn(cell);
  
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
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  cellNib = [UINib nibWithNibName:@"ALCell" bundle:bundle];
  leftLabelCellNib = [UINib nibWithNibName:@"ALLeftLabelCell" bundle:bundle];
}

#pragma mark - Interface - Tests

- (void)test_ALTableViewCellFactory_conformsTo_UITableViewDelegate
{
  expect(sut).to.conformTo(@protocol(UITableViewDelegate));
}

#pragma mark - NSObject - Tests

- (void)test_respondsToSelector_ifDelegateRepondsToSelector_returnsYES
{
  // given
  delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
  sut.delegate = delegate;
  
  // when
  BOOL actual = [sut respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)];
  
  // then
  expect(actual).to.beTruthy();
}

- (void)test_respondsToSelector_ifNeitherDelegateOrSelfRespondsToSelector_returnsNO
{
  // given
  sut.delegate = nil;
  
  // when
  BOOL actual = [sut respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)];
  
  // then
  expect(actual).to.beFalsy();
}

- (void)test_forwardingTargetForSelector_ifDelegateRespondsToSelector_returnsDelegate
{
  // given
  delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
  sut.delegate = delegate;
  
  // when
  id actual = [sut forwardingTargetForSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)];
  
  // then
  expect(actual).to.equal(delegate);
}

#pragma mark - Custom Accessor - Tests

- (void)test_setDelegate_resetsTableViewDataSource {
  
  // given
  [sut setDelegate:nil];
  
  OCMExpect([(UITableView *)tableView setDataSource:nil]);
  OCMExpect([(UITableView *)tableView setDataSource:sut]);
  
  // when
  [sut setDelegate:delegate];
  
  // then
  OCMVerifyAll(tableView);
}

- (void)test_setDelegate_resetsTableViewDelegate {
  
  // given
  [sut setDelegate:nil];
  
  OCMExpect([(UITableView *)tableView setDelegate:nil]);
  OCMExpect([(UITableView *)tableView setDelegate:sut]);
  
  // when
  [sut setDelegate:delegate];
  
  // then
  OCMVerifyAll(tableView);
}

#pragma mark - Register Cells - Tests

- (void)test_initWithTableView_identifiersToNibsDictionary_registersNibDictionary
{
  expect(tableView).toNot.beNil();
  expect(sut.tableView).to.equal(tableView);
  
  [[tableView verify] registerNib:cellNib forCellReuseIdentifier:cellIdentifer];
  [[tableView verify] registerNib:leftLabelCellNib forCellReuseIdentifier:leftCellIdentifier];
}

- (void)test_initWithTableView_identifiersToNibsDictionary_setsDefaultCellSeparatorHeight_to_1
{
  expect(sut.cellSeparatorHeight).to.equal(1.0f);
}

- (void)test_initWithTableView_setsTableView_dataSource
{
  OCMVerify([(UITableView *)tableView setDataSource:sut]);
}

- (void)test_initWithTableView_setsTableView_delegate
{
  OCMVerify([(UITableView *)tableView setDelegate:sut]);
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
  
  [[delegate verify] tableView:sut.tableView configureCell:cell atIndexPath:indexPath];
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
  [[delegate verify] tableView:sut.tableView configureCell:cell atIndexPath:indexPath];
}

- (void)test_heightForCellWithIdentifier_cellIdentifier_addsCellSeparatorHeightToDeterminedContentViewHeight
{
  // given
  tableView = OCMClassMock([UITableView class]);
  sut = [[ALTableViewCellFactory alloc] initWithTableView:tableView identifiersToNibsDictionary:nil];
  
  CGSize systemLayoutSize = CGSizeMake(320.0f, 50.0f);
  id contentView = OCMClassMock([UIView class]);
  OCMStub([contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]).andReturn(systemLayoutSize);
  
  id cell = OCMClassMock([UITableViewCell class]);
  OCMStub([cell contentView]).andReturn(contentView);
  
  OCMStub([tableView dequeueReusableCellWithIdentifier:[OCMArg any]]).andReturn(cell);
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  CGFloat expected = systemLayoutSize.height + sut.cellSeparatorHeight;
  
  // when
  CGFloat actual = [sut cellHeightForIdentifier:@"identifier" atIndexPath:indexPath];
  
  // then
  expect(actual).to.equal(expected);  
}

#pragma mark - UITableViewDelegate - Tests

- (void)test_numberOfSectionsInTableView_ifDelegateRespondsToSelector_asksDelegateForNumberOfSections
{
  // given
  NSInteger expected = 5;
  OCMStub([delegate numberOfSectionsInTableView:sut.tableView]).andReturn(expected);
  
  // when
  NSInteger actual = [sut numberOfSectionsInTableView:sut.tableView];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test_tableView_numberOfRowsInSection_asksDelegateForNumberOfRowsInSection
{
  // given
  NSInteger section = 0;
  NSInteger expected = 4;
  OCMStub([delegate tableView:sut.tableView numberOfRowsInSection:section]).andReturn(expected);
  
  // when
  NSInteger actual = [sut tableView:sut.tableView numberOfRowsInSection:section];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test_tableView_cellForRowAtIndexPath_asksDelegateForCellIdentifier
{
  // given
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  OCMExpect([delegate tableView:sut.tableView identifierForCellAtIndexPath:indexPath]);
  
  // when
  [sut tableView:sut.tableView cellForRowAtIndexPath:indexPath];
  
  // then
  OCMVerifyAll(delegate);
}

#pragma mark - UITableViewDelegate - Tests

- (void)test_tableView_heightForRowAtIndexPath_asksDelegateForCellIdentifier
{
  // given
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  OCMExpect([delegate tableView:sut.tableView identifierForCellAtIndexPath:indexPath]).andReturn(cellIdentifer);
  
  // when
  [sut tableView:sut.tableView heightForRowAtIndexPath:indexPath];
  
  // then
  OCMVerifyAll(delegate);
}

@end
