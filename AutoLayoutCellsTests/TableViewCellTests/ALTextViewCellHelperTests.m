//
//  ALTextViewCellHelperTests.m
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
#import "ALTextViewCellHelper.h"
#import "ALCellConstants.h"
#import "ALTextCellConstants.h"

// Collaborators
#import "ALTextCellDelegate.h"

#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "Test_ALTextCellDelegate.h"

@interface ALTextViewCellHelperTests : XCTestCase
@end

@implementation ALTextViewCellHelperTests
{
  ALTextViewCellHelper *sut;
  
  UITableViewCell *cell;
  ALAutoResizingTextView *textView;
 
  id delegate;
  id mockTextView;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  cell = [[UITableViewCell alloc] init];
  textView = [[ALAutoResizingTextView alloc] init];
  
  sut = [[ALTextViewCellHelper alloc] initWithCell:cell textView:textView];
}

- (void)tearDown
{
  [delegate stopMocking];
  [mockTextView stopMocking];
  
  [super tearDown];
}

#pragma mark - Given

- (void)givenTextInput
{
  textView.text = @"Text";
}

- (void)givenMockDelegate
{
  delegate = OCMClassMock([Test_ALTextCellDelegate class]);
  sut.delegate = delegate;
}

- (void)givenMockTextView
{
  mockTextView = OCMClassMock([UITextView class]);
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithCell_textView___setsProperties
{
  expect(sut.cell).to.equal(cell);
  expect(sut.textView).to.equal(textView);
}

- (void)test___initWithCell_textView___configuresTextView
{
  // given
  [self givenMockTextView];
  
  sut = [ALTextViewCellHelper alloc];
  OCMExpect([mockTextView setDelegate:(id)sut]);
  
  // when
  sut = [sut initWithCell:nil textView:mockTextView];
  
  // then
  OCMVerifyAll(mockTextView);
}

#pragma mark - Values Dictionary - Tests

#pragma mark - Placeholder - Tests

- (void)test___setValuesFromDictionary___setPlaceholderFromDictionary
{
  // given
  NSString *placeholder = @"This is a text placeholder";
  NSDictionary *dictionary = @{ALTextCellPlaceholderTextKey: placeholder};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(textView.placeholder).to.equal(placeholder);
}

#pragma mark - Text - Tests

- (void)test___setValuesFromDictionary___setsTextFromDictionary
{
  // given
  NSString *text = @"This is some text";
  NSDictionary *dictionary = @{ALCellValueKey: text};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(textView.text).to.equal(text);
}

- (void)test___setValuesFromDictionary___setsAttributedText
{
  // given
  NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]};
  NSAttributedString *text = [[NSAttributedString alloc]
                              initWithString:@"This is some text"
                              attributes:attributes];
  NSDictionary *dictionary = @{ALCellAttributedValueKey: text};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(textView.attributedText).to.equal(text);
}

#pragma mark - Type - Tests

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeDefault)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeEmail
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeEmail)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeEmailAddress);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeName
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeName)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeWords);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeNoChecking
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNoChecking)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeNumber
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNumber)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeNumberPad);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeDecimalNumber
{
    // given
    NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeDecimalNumber)};
    
    // when
    [sut setValuesFromDictionary:dict];
    
    // then
    expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
    expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
    expect(textView.keyboardType).to.equal(UIKeyboardTypeDecimalPad);
    expect(textView.secureTextEntry).to.beFalsy();
    expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypePassword
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypePassword)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beTruthy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesFromDictionary___setSextCellType_ALTextCellTypeSentences
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeSentences)};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeYes);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeYes);
}

- (void)test___setValuesFromDictionary___missing_ALTextCellType_doesNotConfigureTextField
{
  // given
  [self givenMockTextView];
  NSDictionary *dict = nil;
  
  [[[mockTextView reject] ignoringNonObjectArgs] setAutocapitalizationType:0];
  [[[mockTextView reject] ignoringNonObjectArgs] setAutocorrectionType:0];
  [[[mockTextView reject] ignoringNonObjectArgs] setKeyboardType:0];
  [[[mockTextView reject] ignoringNonObjectArgs] setSecureTextEntry:NO];
  [[[mockTextView reject] ignoringNonObjectArgs] setSpellCheckingType:0];
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextView);
}

- (void)test___setValuesFromDictionary___invalid_ALTextCellType_doesNotConfigureTextField
{
  // given
  [self givenMockTextView];
  NSDictionary *dict = @{ALTextCellTypeKey: @(NSIntegerMax)};
  
  [[[mockTextView reject] ignoringNonObjectArgs] setAutocapitalizationType:0];
  [[[mockTextView reject] ignoringNonObjectArgs] setAutocorrectionType:0];
  [[[mockTextView reject] ignoringNonObjectArgs] setKeyboardType:0];
  [[[mockTextView reject] ignoringNonObjectArgs] setSecureTextEntry:NO];
  [[[mockTextView reject] ignoringNonObjectArgs] setSpellCheckingType:0];
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextView);
}

#pragma mark - ALAutoResizingTextViewDelegate - Tests

- (void)test_conformsTo___ALSizingTextViewDelegate
{
  expect(sut).to.conformTo(@protocol(ALAutoResizingTextViewDelegate));
}

- (void)test___textView_willChangeFromHeight_toHeight___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  OCMExpect([delegate cellHeightWillChange:cell]);
  
  // when
  [sut textView:textView willChangeFromHeight:10.0f toHeight:50.0f];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test___textView_didChangeFromHeight_toHeight___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  OCMExpect([delegate cellHeightDidChange:cell]);
  
  // when
  [sut textView:textView didChangeFromHeight:10.0f toHeight:50.0f];
  
  // then
  OCMVerifyAll(delegate);
}


#pragma mark - UITextViewDelegate - Tests

- (void)test___textView_shouldChangeTextInRange_replacementText___returnPressed_notifiesDelegate
{
  // given
  [self givenTextInput];
  [self givenMockDelegate];
  
  OCMExpect([delegate cell:cell willEndEditing:textView.text]);
  
  // when
  [sut textView:textView shouldChangeTextInRange:NSMakeRange(0, 3) replacementText:@"\n"];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test___textView_shouldChangeTextInRange_replacementText___returnPressed_resignsResponder
{
  // given
  [self givenMockTextView];
  OCMExpect([mockTextView resignFirstResponder]);
  
  // when
  [sut textView:mockTextView shouldChangeTextInRange:NSMakeRange(0, 3) replacementText:@"\n"];
  
  // then
  OCMVerifyAll(mockTextView);
}

- (void)test___textView_shouldChangeTextInRange_replacementText___returnPressed_doesNotChangeText
{
  // when
  BOOL shouldChange = [sut textView:textView shouldChangeTextInRange:NSMakeRange(0, 3) replacementText:@"\n"];
  
  // then
  expect(shouldChange).to.beFalsy();
}

- (void)test___textViewShouldBeginEditing___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  
  OCMExpect([delegate cellWillBeginEditing:cell]);
  
  // when
  [sut textViewShouldBeginEditing:textView];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test___textViewDidChange___calls_valueChangedBlock
{  
  // given
  [self givenTextInput];
  
  __block BOOL blockCalled = NO;
  
  void (^valueChangedBlock)(id) = ^(NSString *value) {
    
    expect(value).to.equal(textView.text);
    blockCalled = YES;
  };
  
  sut.valueChangedBlock = valueChangedBlock;
  
  // when
  [sut textViewDidChange:textView];
  
  // then
  expect(blockCalled).to.beTruthy();
}

- (void)test___textViewDidChange___notifiesDelegate
{
  // given
  [self givenTextInput];
  [self givenMockDelegate];
  
  OCMExpect([delegate cell:cell valueChanged:textView.text]);
  
  // when
  [sut textViewDidChange:textView];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test___textViewDidEndEditing___notifiesDelegate
{
  // given
  [self givenTextInput];
  [self givenMockDelegate];
  
  OCMExpect([delegate cell:cell didEndEditing:textView.text]);
  
  // when
  [sut textViewDidEndEditing:textView];
  
  // then
  OCMVerifyAll(delegate);
}

@end