//
//  ALTextCellTests.m
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
#import "ALTextViewCell.h"

// Collaborators
#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

#import "ALTextCellDelegate.h"
#import "ALTextViewCellHelper.h"

// Test Support
#import <XCTest/XCTest.h>
#import "Test_ALTableViewCellNibFactory.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTextViewCellTests : XCTestCase
@end

@implementation ALTextViewCellTests
{
  ALTextViewCell *sut;

  id delegate;
  id textView;
  id textViewHelper;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [Test_ALTableViewCellNibFactory cellWithName:@"ALTextViewCell" owner:self];
}

- (void)tearDown
{
  [delegate stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenMockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALTextCellDelegate));
}

- (void)givenMockText
{
  NSString *text = @"Some Test Text";
  sut.textView.text = text;
}

- (void)givenMockTextView
{
  textView = OCMClassMock([UITextView class]);
  sut.textView = textView;
}

- (void)givenMockTextViewHelper
{
  textViewHelper = OCMPartialMock(sut.textViewHelper);
}

#pragma mark - Class - Tests

- (void)test_subclassOf___ALImageCell
{
  expect([sut superclass]).to.beSubclassOf([ALImageCell class]);
}

#pragma mark - Outlets - Tests

- (void)test_has___titleLabel
{
  expect(sut.titleLabel).toNot.beNil();
}

- (void)test_has___subtitleLabel
{
  expect(sut.subtitleLabel).toNot.beNil();
}

- (void)test_has__textView
{
  expect(sut.textView).toNot.beNil();
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

- (void)test_doesNotHave___mainImageViewLeadingConstraint
{
  expect(sut.mainImageViewLeadingConstraint).to.beNil();
}

- (void)test_doesNotHave___secondaryImageView
{
  expect(sut.secondaryImageView).to.beNil();
}

#pragma mark - Object Lifecycle - Tests

- (void)test___commonInit___configuresCell
{
  // given
  sut = [[ALTextViewCell alloc] init];
  
  // then
  expect(sut.selectionStyle).to.equal(UITableViewCellSelectionStyleNone);
}

#pragma mark - Dynamic Type Text - Tests

- (void)test___contentSizeCategoryDidChange___calls___AORefreshFont___on___textView
{
  // given
  [self givenMockTextView];
  
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  OCMExpect([textView setFont:font]);
  
  // when
  [sut contentSizeCategoryDidChange:nil];
  
  // then
  OCMVerifyAll(textView);
}

#pragma mark - Custom Accessors

- (void)test___setDelegate___sets_textViewHelper_delegate
{
  // given
  [self givenMockTextViewHelper];
  [self givenMockDelegate];
  
  OCMExpect([textViewHelper setDelegate:delegate]);
  
  // when
  [sut setDelegate:delegate];
  
  // then
  OCMVerifyAll(textViewHelper);
}

- (void)test___delegate___returns_textViewHelper_delegate
{
  // given
  [self givenMockTextViewHelper];
  [self givenMockDelegate];
  
  OCMStub([textViewHelper delegate]).andReturn(delegate);
  
  // when
  id actual = [sut delegate];
  
  // then
  XCTAssertEqual(actual, delegate);
}

- (void)test___setTextField___setsTextFieldHelper
{
  // given
  textView = [[ALAutoResizingTextView alloc] init];
  
  sut = [[ALTextViewCell alloc] init];
  expect(sut.textViewHelper).to.beNil();
  
  // when
  sut.textView = textView;
  
  // then
  expect(sut.textViewHelper.cell).to.equal(sut);
  expect(sut.textViewHelper.textView).to.equal(textView);
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesFromDictionary___calls_textViewHelper___textView_setValuesFromDictionary
{
  // given
  [self givenMockTextViewHelper];
  NSDictionary *dict = @{};
  
  OCMExpect([textViewHelper setValuesFromDictionary:dict]);
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  OCMVerifyAll(textViewHelper);
}

@end