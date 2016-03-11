//
//  ALSimpleCellViewModelTests.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/8/15.
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
#import "ALTextCellViewModel.h"

// Collaborators
#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

#import "ALTextViewCell.h"
#import "ALTableViewCellNibFactory.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTextCellViewModelTests : XCTestCase
@end

@implementation ALTextCellViewModelTests {
  
  ALTextCellViewModel *sut;

  ALTextViewCell *cell;
  
  id cellTextView;
  id tableView;
}

#pragma mark - Test Lifecycle

- (void)setUp {

  [super setUp];
  
  [self givenMockTableView];
  sut = [[ALTextCellViewModel alloc] initWithCellIdentifier:@"Cell"
                                                  tableView:tableView];
}

- (void)tearDown {
  
  [cellTextView stopMocking];
  [tableView stopMocking];
  [super tearDown];
}

#pragma mark - Given - Mocks

- (void)givenMockTableView {

  tableView = OCMClassMock([UITableView class]);
  sut.tableView = tableView;
}

- (void)givenTextViewCellWithMockTextView {
  
  [self givenTextViewCell];
  
  id textView = OCMClassMock([UITextView class]);
  OCMStub([textView isFirstResponder]).andReturn(YES);
  cell.textView = textView;
}

#pragma mark - Given

- (void)givenTextViewCell {
  
  NSString *name = @"ALTextViewCell";
  cell = [ALTableViewCellNibFactory cellWithName:name owner:nil];
}

#pragma mark - Object Lifecycle

- (void)test___initWithCellIdentifier_tableView___sets_tableView {
  expect(sut.tableView).to.equal(tableView);
}

#pragma mark - ALTextCellDelegate - Tests

- (void)test___cellHeightDidChange___ifTextViewCellTextViewIsntFirstResponder_doesntUpdateTableView {
  
  // given
  [self givenTextViewCell];

  [[tableView reject] beginUpdates];
  [[tableView reject] endUpdates];
  
  // when
  [sut cellHeightDidChange:cell];
  
  // then
  OCMVerifyAll(tableView);
}

- (void)test___cellHeightDidChange___ifTextCellTextViewIsFirstResponder_updatesTableView {
  
  // given
  [self givenTextViewCellWithMockTextView];
  
  OCMExpect([tableView beginUpdates]);
  OCMExpect([tableView endUpdates]);
  
  // when
  [sut cellHeightDidChange:cell];
  
  // then
  OCMVerifyAll(tableView);
}

@end
