//
//  ALTextFieldCellHelper.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/12/14.
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
#import "ALTextFieldCellHelper.h"

// Collaborators
#import "ALTextCellConstants.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "Test_ALCellDelegate.h"

@interface ALTextFieldCellHelperTests : XCTestCase
@end

@implementation ALTextFieldCellHelperTests
{
  ALTextFieldCellHelper *sut;
  
  id delegate;
  UITableViewCell *cell;
  UITextField *textField;
  
  id mockTextField;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  cell = [[UITableViewCell alloc] init];
  textField = [[UITextField alloc] init];
  
  sut = [[ALTextFieldCellHelper alloc] initWithCell:cell textField:textField];
}

- (void)tearDown
{
  [delegate stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenmockTextField
{
  mockTextField = OCMClassMock([UITextField class]);
  sut.textField = mockTextField;
}

- (void)givenMockDelegate
{
  delegate = OCMClassMock([Test_ALCellDelegate class]);
  sut.delegate = delegate;
}

- (void)givenTextInput
{
  textField.text = @"Text";
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithCell_textField___setsInstanceProperties
{
  expect(sut.cell).to.equal(cell);
  expect(sut.textField).to.equal(textField);
}

- (void)test___initWithCell_textField___configuresTextField
{
  // given
  [self givenmockTextField];
  
  sut = [ALTextFieldCellHelper alloc];
  OCMExpect([mockTextField setDelegate:(id)sut]);
  OCMExpect([mockTextField addTarget:sut action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]);
  
  // when
  sut = [sut initWithCell:cell textField:mockTextField];
  
  // then
  OCMVerifyAll(mockTextField);
}

#pragma mark - Set Values From Dictionary - Tests

#pragma mark - Placeholder

- (void)test___setValuesFromDictionary___setsTextField_ALTextCellPlaceholderTextKey
{
  // given
  [self givenmockTextField];
  NSString *placeholder = @"Placeholder";
  NSDictionary *dict = @{ALTextCellPlaceholderTextKey: placeholder};
  
  OCMExpect([mockTextField setPlaceholder:placeholder]);
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextField);
}

- (void)test___setValuesFromDictionary___setsTextField_ALCellAttributedValueKey
{
  // given
  [self givenmockTextField];

  NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"String" attributes:nil];
  NSDictionary *dict = @{ALCellAttributedValueKey: text};

  OCMExpect([mockTextField setAttributedText:text]);

  // when
  [sut setValuesFromDictionary:dict];

  // then
  OCMVerifyAll(mockTextField);
}

- (void)test___setValuesFromDictionary___setsTextField_ALCellValueKey
{
  // given
  [self givenmockTextField];

  NSString *text = @"String";
  NSDictionary *dict = @{ALCellValueKey: text};
  OCMExpect([mockTextField setText:text]);

  // when
  [sut setValuesFromDictionary:dict];

  // then
  OCMVerifyAll(mockTextField);
}

#pragma mark - Type

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeDefault)};

  // when
  [sut setValuesFromDictionary:dict];

  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textField.secureTextEntry).to.beFalsy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypeEmail
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeEmail)};

  // when
  [sut setValuesFromDictionary:dict];

  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeEmailAddress);
  expect(sut.textField.secureTextEntry).to.beFalsy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypeName
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeName)};

  // when
  [sut setValuesFromDictionary:dict];

  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeWords);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textField.secureTextEntry).to.beFalsy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypeNoChecking
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNoChecking)};

  // when
  [sut setValuesFromDictionary:dict];

  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textField.secureTextEntry).to.beFalsy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypeNumber
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNumber)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeNumberPad);
  expect(sut.textField.secureTextEntry).to.beFalsy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypePassword
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypePassword)};

  // when
  [sut setValuesFromDictionary:dict];

  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textField.secureTextEntry).to.beTruthy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellTypeSentences
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeSentences)};

  // when
  [sut setValuesFromDictionary:dict];

  // then
  expect(sut.textField.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(sut.textField.autocorrectionType).to.equal(UITextAutocorrectionTypeYes);
  expect(sut.textField.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textField.secureTextEntry).to.beFalsy();
  expect(sut.textField.spellCheckingType).to.equal(UITextSpellCheckingTypeYes);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellType_missing_doesNotConfigureTextField
{
  // given
  [self givenmockTextField];
  NSDictionary *dict = nil;

  [[[mockTextField reject] ignoringNonObjectArgs] setAutocapitalizationType:0];
  [[[mockTextField reject] ignoringNonObjectArgs] setAutocorrectionType:0];
  [[[mockTextField reject] ignoringNonObjectArgs] setKeyboardType:0];
  [[[mockTextField reject] ignoringNonObjectArgs] setSecureTextEntry:NO];
  [[[mockTextField reject] ignoringNonObjectArgs] setSpellCheckingType:0];

  // when
  [sut setValuesFromDictionary:dict];

  // then
  OCMVerifyAll(mockTextField);
}

- (void)test___setValuesFromDictionary___textCellType___ALTextCellType_invalidType_doesNotConfigureTextField
{
  // given
  [self givenmockTextField];
  NSDictionary *dict = @{ALTextCellTypeKey: @(NSIntegerMax)};

  [[[mockTextField reject] ignoringNonObjectArgs] setAutocapitalizationType:0];
  [[[mockTextField reject] ignoringNonObjectArgs] setAutocorrectionType:0];
  [[[mockTextField reject] ignoringNonObjectArgs] setKeyboardType:0];
  [[[mockTextField reject] ignoringNonObjectArgs] setSecureTextEntry:NO];
  [[[mockTextField reject] ignoringNonObjectArgs] setSpellCheckingType:0];

  // when
  [sut setValuesFromDictionary:dict];

  // then
  OCMVerifyAll(mockTextField);
}

#pragma mark - UITextFieldDelegate - Tests

- (void)test___textField_shouldChangeTextInRange_replacementText___returnPressed_notifiesDelegate
{
  // given
  [self givenTextInput];
  [self givenMockDelegate];

  OCMExpect([delegate cell:cell willEndEditing:textField.text]);

  // when
  [sut textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 3) replacementString:@"\n"];

  // then
  OCMVerifyAll(delegate);
}

- (void)test___textField_shouldChangeTextInRange_replacementText___returnPressed_resignsResponder
{
  // given
  [self givenmockTextField];
  OCMExpect([mockTextField resignFirstResponder]);

  // when
  [sut textField:mockTextField shouldChangeCharactersInRange:NSMakeRange(0, 3) replacementString:@"\n"];

  // then
  OCMVerifyAll(mockTextField);
}

- (void)test___textField_shouldChangeTextInRange_replacementText___returnPressed_doesNotChangeText
{
  // when
  BOOL shouldChange = [sut textField:textField shouldChangeCharactersInRange:NSMakeRange(0, 3) replacementString:@"\n"];

  // then
  expect(shouldChange).to.beFalsy();
}

- (void)test___textFieldShouldBeginEditing___notifiesDelegate
{
  // given
  [self givenMockDelegate];

  OCMExpect([delegate cellWillBeginEditing:cell]);

  // when
  [sut textFieldShouldBeginEditing:textField];

  // then
  OCMVerifyAll(delegate);
}

- (void)test___textViewDidChange___calls_valueChangedBlock
{
  // given
  [self givenTextInput];
  
  __block BOOL blockCalled = NO;
  
  void (^valueChangedBlock)(id) = ^(NSString *value) {
    
    expect(value).to.equal(textField.text);
    blockCalled = YES;
  };
  
  sut.valueChangedBlock = valueChangedBlock;
  
  // when
  [sut textFieldDidChange:textField];
  
  // then
  expect(blockCalled).to.beTruthy();
}

- (void)test___textFieldDidChange___notifiesDelegate
{
  // given
  [self givenTextInput];
  [self givenMockDelegate];

  OCMExpect([delegate cell:cell valueChanged:textField.text]);

  // when
  [sut textFieldDidChange:textField];

  // then
  OCMVerifyAll(delegate);
}

- (void)test___textFieldDidEndEditing___notifiesDelegate
{
  // given
  [self givenTextInput];
  [self givenMockDelegate];

  OCMExpect([delegate cell:cell didEndEditing:textField.text]);

  // when
  [sut textFieldDidEndEditing:textField];

  // then
  OCMVerifyAll(delegate);
}

@end