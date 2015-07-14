//
//  ALTableViewManagerTests.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 7/13/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
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
#import "ALTableViewManager.h"

// Collaborators
#import "ALBaseCell.h"
#import "ALCellViewModel.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTableViewManager ()
@property (strong, nonatomic, readwrite) UITableView *tableView;
@end

@interface ALTableViewManagerTests : XCTestCase
@end

@implementation ALTableViewManagerTests
{
  ALTableViewManager *sut;
  
  CGFloat estimatedRowHeight;
  UITableView *tableView;
  
  NSArray *mockViewModelArrays;
  id partialMock;
  id partialMockTableView;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  estimatedRowHeight = 100.0f;
  tableView = [[UITableView alloc] init];

  sut = [[ALTableViewManager alloc] initWithTableView:tableView
                                   estimatedRowHeight:estimatedRowHeight];
}

- (void)tearDown
{
  [partialMock stopMocking];
  [partialMockTableView stopMocking];
  [self stopMockingViewMocks];
  
  [super tearDown];
}

- (void)stopMockingViewMocks
{
  for (NSArray *array in mockViewModelArrays) {
    [array makeObjectsPerformSelector:@selector(stopMocking)];
  }
}

#pragma mark - Given Mocks

- (void)givenMockViewModelsWithSections:(NSUInteger)sectionsCount
                                   rows:(NSUInteger)rowsCount
{
  NSMutableArray *sections = [NSMutableArray arrayWithCapacity:sectionsCount];
  
  for (NSUInteger s = 0; s < sectionsCount; s++) {
    
    NSArray *rows = [self givenMockViewMockRowsWithCount:rowsCount];
    [sections addObject:rows];
  }
  
  mockViewModelArrays = [sections copy];
  sut.viewModelArrays = mockViewModelArrays;
}

- (NSArray *)givenMockViewMockRowsWithCount:(NSUInteger)count
{
  NSMutableArray *rows = [NSMutableArray arrayWithCapacity:count];
  
  for (NSUInteger i = 0; i < count; i++) {
    
    id mock = OCMProtocolMock(@protocol(ALCellViewModel));
    [rows addObject:mock];
  }
  
  return [rows copy];
}

- (void)givenPartialMock
{
  partialMock = OCMPartialMock(sut);
}

- (void)givenPartialMockTableView
{
  partialMockTableView = OCMPartialMock(sut.tableView);
}

#pragma mark - Class - Tests

- (void)test_conformsTo_UITableViewDataSource
{
  expect(sut).to.conformTo(@protocol(UITableViewDataSource));
}

- (void)test_conformsTo_UITableViewDelegate
{
  expect(sut).to.conformTo(@protocol(UITableViewDelegate));
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithTableView_estimatedRowHeight__setsEstimatedRowHeight
{
  expect(sut.estimatedRowHeight).to.equal(estimatedRowHeight);
}

- (void)test___initWithTableView_estimatedRowHeight___setsTableView
{
  expect(sut.tableView).to.equal(tableView);
}

- (void)test___initWithTableView_estimatedRowHeight___setsTableViewDataSource
{
  expect(sut.tableView.dataSource).to.equal(sut);
}

- (void)test___initWithTableView_estimatedRowHeight___setsTableViewDelegate
{
  expect(sut.tableView.delegate).to.equal(sut);
}

- (void)test___initWithTableView_estimatedRowHeight___setsTableViewRowHeight
{
  expect(sut.tableView.rowHeight).to.equal(UITableViewAutomaticDimension);
}

- (void)test___initWithTableView_estimatedRowHeight__setsTableViewEstimatedRowHeight
{
  expect(sut.tableView.estimatedRowHeight).to.equal(estimatedRowHeight);
}

- (void)test___initWithTableView_estimatedRowHeight__calls_registerCells {
  
  // given
  sut = [ALTableViewManager alloc];

  [self givenPartialMock];
  OCMExpect([partialMock registerCells]);
  
  // when
  sut = [sut initWithTableView:tableView estimatedRowHeight:estimatedRowHeight];
  
  // then
  OCMVerifyAll(partialMock);
}

#pragma mark - Custom Accessors - Tests

- (void)test___setViewModelArrays___setsViewModelArrays
{
  // when
  [self givenMockViewModelsWithSections:3 rows:3];
  
  // then
  expect(sut.viewModelArrays).to.equal(mockViewModelArrays);
}

- (void)test___setViewModels___calls_tableView_reloadData
{
  // given
  [self givenPartialMockTableView];
  OCMExpect([partialMockTableView reloadData]);
  
  [self givenMockViewModelsWithSections:3 rows:3];
  
  // when
  sut.viewModelArrays = mockViewModelArrays;
  
  // then
  OCMVerifyAll(partialMockTableView);
}

#pragma mark - UITableViewDataSource - Tests

- (void)test___numberOfSectionsInTableView___returns_viewModelsSectionsCount
{
  // given
  NSUInteger sections = 7;
  NSUInteger rows = 2;
  [self givenMockViewModelsWithSections:sections rows:rows];
  
  // when
  NSUInteger actual = [sut numberOfSectionsInTableView:sut.tableView];
  
  // then
  expect(actual).to.equal(sections);
}

- (void)test___tableView_numberOfRowsInSection___givenEqualRowsPerSection_returnsExpectedRowsCount
{
  // given
  NSUInteger sections = 7;
  NSUInteger rows = 2;
  [self givenMockViewModelsWithSections:sections rows:rows];
  
  // when
  NSUInteger actual = [sut tableView:tableView numberOfRowsInSection:0];
  
  // then
  expect(actual).to.equal(rows);
}

- (void)test___tableView_numberOfRowsInSection___givenUnequalRowsPerSection_returnsExpectedRowsCount
{
  // given
  NSUInteger expected = 4;
  mockViewModelArrays = @[[self givenMockViewMockRowsWithCount:expected+1],
                          [self givenMockViewMockRowsWithCount:expected]];
  sut.viewModelArrays = mockViewModelArrays;
  
  // when
  NSUInteger actual = [sut tableView:tableView numberOfRowsInSection:1];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___tableView_cellForRowAtIndexPath___returnsCellForViewModelAtIndexPath
{
  // given
  [self givenMockViewModelsWithSections:3 rows:3];
  
  NSUInteger section = 2;
  NSUInteger row = 1;
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
  
  UITableViewCell *expected = [UITableViewCell new];
  id viewModel = mockViewModelArrays[section][row];
  OCMStub([viewModel tableView:tableView cellForRowAtIndexPath:indexPath]).andReturn(expected);
  
  // when
  UITableViewCell *actual = [sut tableView:tableView cellForRowAtIndexPath:indexPath];
  
  // then
  expect(actual).to.equal(expected);
}

#pragma mark - UITableViewDelegate - Tests

- (void)test___tableView_didSelectRowAtIndexPath___givenALBaseCellHasDidSelectCellBlock_calls_didSelectCellBlock {
  
  // given
  __block BOOL didSelectCellBlockCalled = NO;
  
  ALBaseCell *cell = [ALBaseCell new];
  cell.didSelectCellBlock = ^{
    didSelectCellBlockCalled = YES;
  };
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

  [self givenPartialMockTableView];
  OCMStub([partialMockTableView cellForRowAtIndexPath:indexPath]).andReturn(cell);
  
  // when
  [sut tableView:tableView didSelectRowAtIndexPath:indexPath];
  
  // then
  expect(didSelectCellBlockCalled).to.beTruthy();
}

- (void)test___tableView_didSelectRowAtIndexPath___givenALBaseCellDoesntHaveDidSelectCellBlock_doesntCall {
  
  // given
  ALBaseCell *cell = [ALBaseCell new];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  [self givenPartialMockTableView];
  OCMStub([partialMockTableView cellForRowAtIndexPath:indexPath]).andReturn(cell);
  
  // then
  XCTAssertNoThrow([sut tableView:tableView didSelectRowAtIndexPath:indexPath]);
}

- (void)test___tableView_didSelectRowAtIndexPath___givenCellDoesntRespondToDidSelectCellBlock_doesntCall {
  
  // given
  UITableViewCell *cell = [UITableViewCell new];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  [self givenPartialMockTableView];
  OCMStub([partialMockTableView cellForRowAtIndexPath:indexPath]).andReturn(cell);
  
  // then
  XCTAssertNoThrow([sut tableView:tableView didSelectRowAtIndexPath:indexPath]);
}

@end
