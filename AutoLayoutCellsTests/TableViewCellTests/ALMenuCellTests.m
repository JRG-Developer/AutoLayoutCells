//
//  ALMenuCellTests.m
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
#import "ALImageCell.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>
#import "ALTableViewCellNibFactory.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

@interface ALMenuCellTests : XCTestCase
@end

@implementation ALMenuCellTests
{
  ALImageCell *sut;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [ALTableViewCellNibFactory cellWithName:@"ALMenuCell" owner:self];
}

#pragma mark - Class - Tests

- (void)test_instanceOf___ALImageCell
{
  expect(sut).to.beInstanceOf([ALImageCell class]);
}

#pragma mark - Outlet - Tests

- (void)test_has___titleLabel
{
  expect(sut.titleLabel).toNot.beNil();
}

- (void)test_has___subtitleLabel
{
  expect(sut.subtitleLabel).toNot.beNil();
}

- (void)test_has___mainImageView
{
  expect(sut.mainImageView).toNot.beNil();
}

- (void)test_has___mainImageViewTrailingConstraint
{
  expect(sut.mainImageViewTrailingConstraint).toNot.beNil();
}

- (void)test_has___mainImageViewWidthConstraint
{
  expect(sut.mainImageViewWidthConstraint).toNot.beNil();
}

- (void)test_has___mainImageViewHeightConstraint
{
  expect(sut.mainImageViewHeightConstraint).toNot.beNil();
}

- (void)test_doesNotHave___mainImageViewLeadingConstraint
{
  expect(sut.mainImageViewLeadingConstraint).to.beNil();
}

- (void)test_has___secondaryImageView
{
  expect(sut.secondaryImageView).toNot.beNil();
}

- (void)test_has___secondaryImageViewLeadingConstraint
{
  expect(sut.secondaryImageViewLeadingConstraint).toNot.beNil();
}

- (void)test_has___secondaryImageViewWidthConstraint
{
  expect(sut.secondaryImageViewWidthConstraint).toNot.beNil();
}

- (void)test_has___secondaryImageViewHeightConstraint
{
  expect(sut.secondaryImageViewHeightConstraint).toNot.beNil();
}

- (void)test_doesNotHave___secondaryImageViewTrailingConstraint
{
  expect(sut.secondaryImageViewTrailingConstraint).to.beNil();
}

@end