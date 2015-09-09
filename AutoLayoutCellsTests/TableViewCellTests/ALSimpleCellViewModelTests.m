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

@interface ALSimpleCellViewModelTests : XCTestCase
@end

@implementation ALSimpleCellViewModelTests {
  
  ALSimpleCellViewModel *sut;
  NSString *cellIdentifier;
  
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  
  [super setUp];
  cellIdentifier = @"Test_CellIdentifier";
  sut = [[ALSimpleCellViewModel alloc] initWithCellIdentifier:cellIdentifier];
}

- (void)tearDown {
  
  [partialMock stopMocking];
  [super tearDown];
}

#pragma mark - Given - Mocks

- (void)givenPartialMock {
  
  partialMock = OCMPartialMock(sut);
}

#pragma mark - Class - Tests

- (void)test___conformsTo___ALCellViewModel {
  
  expect(sut).to.conformTo(@protocol(ALCellViewModel));
}

#pragma mark - Object Lifecycle - Tests

- (void)test___init___calls_initWithCellIdentifier {
  
  // given
  sut = [ALSimpleCellViewModel alloc];
  
  [self givenPartialMock];
  OCMExpect([partialMock initWithCellIdentifier:nil]);
  
  // when
  sut = [sut init];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithCellIdentifier___sets_cellIdentifier {
  
  expect(sut.cellIdentifier).to.equal(cellIdentifier);
}

#pragma mark - ALCellViewModel - Tests

- (void)test___configureCell___givenHasConfigureCellBlock_calls_configureCellBlock {
  
  // given
  UITableViewCell *expected = [[UITableViewCell alloc] init];
  __block BOOL configureCellBlockCalled = NO;
  
  void (^configureCellBlock)(id) = ^(id cell) {
    
    configureCellBlockCalled = YES;
    expect(cell).to.equal(expected);
  };
  
  sut.configureCellBlock = configureCellBlock;
  
  // when
  [sut configureCell:expected];
  
  // then
  expect(configureCellBlockCalled).to.beTruthy();
}

- (void)test___configureCellBlock___givenConfigureCellBlockIsNil_doesntCallBlock {
  
  // given
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  
  // then
  XCTAssertNoThrow([sut configureCell:cell]);
}

- (void)test___didSelectCell___givenHasDidSelectCellBlock_calls_didSelectCellBlock {
  
  UITableViewCell *expected = [[UITableViewCell alloc] init];
  __block BOOL didSelectCellBlockCalled = NO;
  
  void (^didSelectCellBlock)(id) = ^(id cell) {
    
    didSelectCellBlockCalled = YES;
    expect(cell).to.equal(expected);
  };
  
  sut.didSelectCellBlock = didSelectCellBlock;
  
  // when
  [sut didSelectCell:expected];
  
  // then
  expect(didSelectCellBlockCalled).to.beTruthy();
}

@end
