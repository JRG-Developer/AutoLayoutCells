//
//  ALBooleanCellTests.m
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
#import "ALBooleanCell.h"
#import "ALCellConstants.h"

// Collaborators
#import "ALCellDelegate.h"
#import "Test_ALTableViewCellNibFactory.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALBooleanCellTests : XCTestCase
@end

@implementation ALBooleanCellTests
{
  ALBooleanCell *sut;
  id delegate;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [Test_ALTableViewCellNibFactory cellWithName:@"ALBooleanCell" owner:self];
}

#pragma mark - Given

- (void)givenMockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALCellDelegate));
  sut.delegate = delegate;
}

#pragma mark - When

- (void)whenSetValuesWithToggleDictionaryValue:(BOOL)value
{
  NSDictionary *dictionary = @{ALCellValueKey: @(value)};
  [sut setValuesDictionary:dictionary];
}

#pragma mark - Class - Tests

- (void)test_subclassOf___ALImageCell
{
  expect([sut class]).to.beSubclassOf([ALImageCell class]);
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

- (void)test_doesNotHave___secondaryImageView
{
  expect(sut.secondaryImageView).to.beNil();
}

- (void)test_has___toggle
{
  expect(sut.toggle).toNot.beNil();
}

- (void)test_has___toggle_method_set
{
  expect([sut.toggle actionsForTarget:sut forControlEvent:UIControlEventValueChanged].count).to.beGreaterThan(0);
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesDictionary___setToggleValueToYES
{
  // when
  [self whenSetValuesWithToggleDictionaryValue:YES];
  
  // then
  expect([sut.toggle isOn]).to.beTruthy();
}

- (void)test___setValuesDictionary___setToggleValueToNO
{
  // when
  [self whenSetValuesWithToggleDictionaryValue:NO];
  
  // then
  expect([sut.toggle isOn]).to.beFalsy();
}

#pragma mark - Did Toggle - Tests

- (void)test___didToggle___notifiesDelegate___cell___valueChanged
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut didToggle:sut.toggle];
  
  // then
  [[delegate verify] cell:sut valueChanged:@([sut.toggle isOn])];
}

@end