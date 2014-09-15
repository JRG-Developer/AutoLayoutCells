//
//  ALTextFieldCell.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/10/14.
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
#import "ALTextCellConstants.h"
#import "ALCellDelegate.h"
#import "ALTextFieldCellHelper.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

#import "Test_ALTableViewCellNibFactory.h"

@interface ALTextFieldCellTests : XCTestCase
@end

@implementation ALTextFieldCellTests
{
  ALTextFieldCell *sut;

  id delegate;
  id textField;
  id textFieldHelper;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [Test_ALTableViewCellNibFactory cellWithName:@"ALTextFieldCell" owner:self];
}

#pragma mark - Given

- (void)givenMockTextField
{
  textField = OCMClassMock([UITextField class]);
  sut.textField = textField;
}

- (void)givenMockTextFieldHelper
{
  textFieldHelper = OCMPartialMock(sut.textFieldHelper);
}

- (void)givenMockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALCellDelegate));
  sut.delegate = delegate;
}

#pragma mark - Outlet - Tests

- (void)test_has___titleLabel
{
  expect(sut.titleLabel).toNot.beNil();
}

- (void)test_has___textField
{
  expect(sut.textField).toNot.beNil();
}

#pragma mark - Object Lifecycle - Tests

- (void)test___commonInit___configuresCell
{
  // given
  sut = [[ALTextFieldCell alloc] init];
  
  // then
  expect(sut.selectionStyle).to.equal(UITableViewCellSelectionStyleNone);
}

- (void)test___awakeFromNib___setsUpTextFieldHelper
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut awakeFromNib];
  
  // then
  expect(sut.textFieldHelper.cell).to.equal(sut);
  expect(sut.textFieldHelper.textField).to.equal(sut.textField);
  expect(sut.textFieldHelper.delegate).to.equal(sut.delegate);
}

#pragma mark - Custom Accessor - Tests

- (void)test___setDelegate___sets_textFieldHelper_delegate
{
  // given
  delegate = OCMProtocolMock(@protocol(ALCellDelegate));
  
  [self givenMockTextFieldHelper];
  OCMExpect([textFieldHelper setDelegate:delegate]);
  
  // when
  sut.delegate = delegate;
  
  // then
  OCMVerifyAll(textFieldHelper);
}

#pragma mark - Dynamic Type Text

- (void)test___refreshFonts___refreshes_textField
{
  // given
  [self givenMockTextField];
  
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  
  OCMExpect([textField setFont:font]);
  
  // when
  [sut refreshFonts];
  
  // then
  OCMVerifyAll(textField);
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesFromDictionary___calls_textViewHelper___textView_setValuesFromDictionary
{
  // given
  [self givenMockTextFieldHelper];
  NSDictionary *dict = @{};
  
  OCMExpect([textFieldHelper setValuesFromDictionary:dict]);
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  OCMVerifyAll(textFieldHelper);
}


@end