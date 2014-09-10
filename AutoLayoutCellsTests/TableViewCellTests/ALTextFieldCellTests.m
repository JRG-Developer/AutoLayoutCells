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
#import "UIView+ALRefreshFont.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTextFieldCellTests : XCTestCase
@end

@implementation ALTextFieldCellTests
{
  ALTextFieldCell *sut;

  UITextField *textField;
  id mockTextField;
  id mockDelegate;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[ALTextFieldCell alloc] init];
  textField = [[UITextField alloc] init];
  sut.textField = textField;
}

#pragma mark - Given

- (void)givenMockTextField
{
  mockTextField = OCMClassMock([UITextField class]);
  sut.textField = mockTextField;
}

- (void)givenMockDelegate
{
  mockDelegate = OCMProtocolMock(@protocol(ALCellDelegate));
  sut.delegate = mockDelegate;
}

#pragma mark - Object Lifecycle - Tests

- (void)test___awakeFromNib___configuresTextField
{
  // given
  [self givenMockTextField];
  
  OCMExpect([mockTextField addTarget:sut
                          action:@selector(textFieldValueChanged:)
                forControlEvents:UIControlEventValueChanged]);
  
  OCMExpect([mockTextField setDelegate:(id)sut]);
  
  // when
  [sut awakeFromNib];
  
  // then
  OCMVerifyAll(mockTextField);
}

#pragma mark - Dynamic Type Text

- (void)test___refreshFonts___refresh_textField
{
  // given
  [self givenMockDelegate];
  
  OCMExpect([mockTextField AL_refreshPreferredFont]);
  
  // when
  [sut refreshFonts];
  
  // then
  OCMVerifyAll(mockTextField);
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesDictionary___setsTextField_ALCellAttributedValueKey
{
  // given
  [self givenMockTextField];
  
  NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"String" attributes:nil];
  NSDictionary *dict = @{ALCellAttributedValueKey: text};
  
  OCMExpect([mockTextField setAttributedText:text]);
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextField);
}

- (void)test___setValuesDictionary___setsTextField_ALCellValueKey
{
  // given
  [self givenMockTextField];
  
  NSString *text = @"String";
  NSDictionary *dict = @{ALCellValueKey: text};
  OCMExpect([mockTextField setText:text]);
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextField);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeEmail
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeEmail)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeEmailAddress);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeName
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeName)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeWords);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeNoChecking
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNoChecking)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypePassword
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypePassword)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textField.secureTextEntry).to.beTruthy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeSentences
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeSentences)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeYes);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeYes);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeDefault)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeNumber
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNumber)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeNumberPad);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___defaultsTo___ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(NSIntegerMax)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textField.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textField.secureTextEntry).to.beFalsy();
  expect(textField.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

#pragma mark - Text Field Actions - Tests

- (void)test___textFieldShouldBeginEditing___notifiesDelegate___cellWillBeginEditing
{
  // given
  [self givenMockDelegate];
  OCMExpect([mockDelegate cellWillBeginEditing:sut]);
  
  // when
  [sut textFieldShouldBeginEditing:sut.textField];
  
  // then
  OCMVerifyAll(mockDelegate);
}

- (void)test___textFieldShouldBeginEditing___returns_YES
{
  expect([sut textFieldShouldBeginEditing:sut.textField]).to.beTruthy();
}

- (void)test___textFieldValueChanged___notifiesDelegate___cell_valueChanged
{
  // given
  [self givenMockDelegate];
  
  sut.textField.text = @"Text";
  OCMExpect([mockDelegate cell:sut valueChanged:sut.textField.text]);
  
  // when
  [sut textFieldValueChanged:sut.textField];
  
  // then
  OCMVerifyAll(mockDelegate);
}

- (void)test___textFieldDidEndEditing___notifiesDelegate___cell_didEndEditing
{
  // given
  [self givenMockDelegate];
  
  sut.textField.text = @"Text";
  OCMExpect([mockDelegate cell:sut didEndEditing:sut.textField.text]);
  
  // when
  [sut textFieldDidEndEditing:textField];
  
  // then
  OCMVerifyAll(mockDelegate);
}

@end