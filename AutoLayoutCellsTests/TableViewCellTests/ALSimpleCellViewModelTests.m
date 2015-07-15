//
//  ALSimpleCellViewModelTests.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 7/14/15.
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
#import "ALSimpleCellViewModel.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

static NSString *ALSimpleCellIdentifier = @"SimpleCell";

@interface ALSimpleCellViewModelTests : XCTestCase
@end

@implementation ALSimpleCellViewModelTests
{
  ALSimpleCellViewModel *sut;
  
  id model;
  UITableViewCell * (^cellForTableViewBlock)(UITableView *);
  void (^didSelectCellBlock)();
  NSArray *editActionsForCell;
  
  id mockTableView;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  model = [NSObject new];
  cellForTableViewBlock = ^UITableViewCell *(UITableView *tableView) { return nil; };
  didSelectCellBlock = ^{ };
  editActionsForCell = @[];
  
  sut = [[ALSimpleCellViewModel alloc] initWithModel:model
                               cellForTableViewBlock:cellForTableViewBlock
                                  didSelectCellBlock:didSelectCellBlock
                                         editActionsForCell:editActionsForCell];
}

- (void)tearDown
{
  [mockTableView stopMocking];
  [super tearDown];
}

#pragma mark - Given - Mocks

- (void)givenMockTableView
{
  mockTableView = OCMClassMock([UITableView class]);
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithModel_et_all___sets_model
{
  expect(sut.model).to.equal(model);
}

- (void)test___initWithModel_et_all___sets_cellForTableViewBlock
{
  expect(sut.cellForTableViewBlock).to.equal(cellForTableViewBlock);
}

- (void)test___initWithModel_et_all___sets_didSelectCellBlock
{
  expect(sut.didSelectCellBlock).to.equal(didSelectCellBlock);
}

- (void)test___initWithModel_et_all___sets_editActionsForCell
{
  expect(sut.editActionsForCell).to.equal(editActionsForCell);
}

#pragma mark - ALCellViewModel - Tests

- (void)test___cellForTableView___returns_tableViewCellFrom_cellForTableViewBlock {
  
  // given
  UITableViewCell *expected = [UITableViewCell new];

  [self givenMockTableView];
  OCMStub([mockTableView dequeueReusableCellWithIdentifier:ALSimpleCellIdentifier]).andReturn(expected);
  
  sut.cellForTableViewBlock = ^UITableViewCell *(UITableView *tableView) {
    return [tableView dequeueReusableCellWithIdentifier:ALSimpleCellIdentifier];
  };
  
  // when
  UITableViewCell *actual = [sut cellForTableView:mockTableView];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___didSelectCell___calls_didSelectCellBlock {
  
  // given
  __block BOOL didSelectCellBlockCalled = NO;
  sut.didSelectCellBlock = ^{
    didSelectCellBlockCalled = YES;
  };
  
  // when
  [sut didSelectCell];
  
  // then
  expect(didSelectCellBlockCalled).to.beTruthy();
}

@end
