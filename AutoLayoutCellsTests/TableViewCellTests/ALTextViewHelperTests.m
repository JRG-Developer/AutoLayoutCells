//
//  ALTextViewHelperTests.m
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
#import "ALTextViewHelper.h"
#import "ALCellConstants.h"
#import "ALTextCellConstants.h"

// Collaborators
#import "ALTextViewHelperDelegate.h"

#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTextViewHelperTests : XCTestCase
@end

@implementation ALTextViewHelperTests
{
  id delegate;
  ALTextViewHelper *sut;
  ALAutoResizingTextView *textView;
  
  id mockTextView;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[ALTextViewHelper alloc] init];
  textView = [[ALAutoResizingTextView alloc] init];
}

#pragma mark - Given

- (void)givenMockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALTextViewHelperDelegate));
  sut.delegate = delegate;
}

- (void)givenMockTextView
{
  mockTextView = OCMClassMock([UITextView class]);
}

#pragma mark - Set Value - Tests

- (void)test___textView_setPlaceholderFromDictionary
{
  // given
  NSString *placeholder = @"This is a text placeholder";
  NSDictionary *dictionary = @{ALTextCellPlaceholderTextKey: placeholder};
  
  // when
  [ALTextViewHelper textView:textView setPlaceholderFromDictionary:dictionary];
  
  // then
  expect(textView.placeholder).to.equal(placeholder);
}

- (void)test___textView_setTextFromDictionary___text
{
  // given
  NSString *text = @"This is some text";
  NSDictionary *dictionary = @{ALCellValueKey: text};
  
  // when
  [ALTextViewHelper textView:textView setTextFromDictionary:dictionary];
  
  // then
  expect(textView.text).to.equal(text);
}

- (void)test___textView_setTextFromDictionary___attributedText
{
  // given
  NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]};
  NSAttributedString *text = [[NSAttributedString alloc]
                              initWithString:@"This is some text"
                              attributes:attributes];
  NSDictionary *dictionary = @{ALCellAttributedValueKey: text};
  
  // when
  [ALTextViewHelper textView:textView setTextFromDictionary:dictionary];
  
  // then
  expect(textView.attributedText).to.equal(text);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeEmail
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeEmail)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeEmailAddress);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeName
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeName)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeWords);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeNoChecking
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNoChecking)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypePassword
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypePassword)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beTruthy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeSentences
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeSentences)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeYes);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeYes);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeDefault)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeNumber
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNumber)};
  
  // when
  [ALTextViewHelper textView:textView setTypeFromDictionary:dict];
  
  // then
  expect(textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(textView.keyboardType).to.equal(UIKeyboardTypeNumberPad);
  expect(textView.secureTextEntry).to.beFalsy();
  expect(textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellType_missing_doesNotConfigureTextField
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
  [ALTextViewHelper textView:mockTextView setTypeFromDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextView);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellType_invalidType_doesNotConfigureTextField
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
  [ALTextViewHelper textView:mockTextView setTypeFromDictionary:dict];
  
  // then
  OCMVerifyAll(mockTextView);
}

#pragma mark - UITextViewDelegate - Tests

- (void)test_conformsTo___UITextViewDelegate
{
  expect(sut).to.conformTo(@protocol(UITextViewDelegate));
}

- (void)test_textViewReturnPressedCalls___notifiesDelegate___textViewHelper_textViewWillEndEditing
{
  // given
  [self givenMockDelegate];
  [self givenMockTextView];
  
  OCMExpect([delegate textViewHelper:sut textViewWillEndEditing:mockTextView]);
  
  // when
  [sut textView:mockTextView shouldChangeTextInRange:NSMakeRange(0, 3) replacementText:@"\n"];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test_textViewReturnPressedCalls___resignsResponder
{
  // given
  [self givenMockTextView];
  
  // when
  [sut textView:mockTextView shouldChangeTextInRange:NSMakeRange(0, 3) replacementText:@"\n"];
  
  // then
  [[mockTextView verify] resignFirstResponder];
}


- (void)test_textViewDoesNotChangeTextOnReturn
{
  // given
  [self givenMockTextView];
  
  // when
  BOOL shouldChange = [sut textView:mockTextView shouldChangeTextInRange:NSMakeRange(0, 3) replacementText:@"\n"];
  
  // then
  expect(shouldChange).to.beFalsy();
}

- (void)test_notifiesDelegateWhen___textViewShouldBeginEditing
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut textViewShouldBeginEditing:textView];
  
  // then
  [[delegate verify] textViewHelper:sut
           textViewWillBeginEditing:textView];
}

- (void)test_notifiesDelegateWhen___textViewDidChange
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut textViewDidChange:textView];
  
  // then
  [[delegate verify] textViewHelper:sut
                  textViewDidChange:textView];
}


- (void)test_notifiesDelegateWhen___textViewDidEndEditing
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut textViewDidEndEditing:textView];
  
  // then
  [[delegate verify] textViewHelper:sut
              textViewDidEndEditing:textView];
}

@end