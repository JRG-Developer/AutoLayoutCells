//
//  ALTextFieldOnlyTests.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/11/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
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
#import "ALTextFieldCell.h"
// Collaborators

// Test Support
#import <XCTest/XCTest.h>
#import "Test_ALTableViewCellNibFactory.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>


@interface ALTextFieldOnlyTests : XCTestCase
@end

@implementation ALTextFieldOnlyTests
{
  ALTextFieldCell *sut;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [Test_ALTableViewCellNibFactory cellWithName:@"ALTextFieldOnlyCell" owner:self];
}

#pragma mark - Outlets - Tests

- (void)test_has___textField
{
  expect(sut.textField).toNot.beNil();
}

- (void)test_doesNotHave___titleLabel
{
  expect(sut.titleLabel).to.beNil();
}

- (void)test_doesNotHave___subtitleLabel
{
  expect(sut.subtitleLabel).to.beNil();
}

@end