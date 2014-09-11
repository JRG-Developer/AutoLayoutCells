//
//  ALTextOnlyCellTests.m
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
#import "ALTextOnlyCell.h"

// Collaborators
#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

#import "ALTextCellDelegate.h"

// Test Support
#import <XCTest/XCTest.h>
#import "ALCellConstants.h"
#import "ALTextCellConstants.h"
#import "Test_ALTableViewCellNibFactory.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTextOnlyCellTests : XCTestCase
@end

@implementation ALTextOnlyCellTests
{
  ALTextOnlyCell *sut;
  id delegate;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [Test_ALTableViewCellNibFactory cellWithName:@"ALTextOnlyCell" owner:self];
}

#pragma mark - Utilities

- (void)givenMockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALTextCellDelegate));
  sut.delegate = delegate;
}

- (void)givenMockText
{
  NSString *text = @"Some Test Text";
  sut.textView.text = text;
}

#pragma mark - Class - Tests

- (void)test_subclassOf___ALBaseCell
{
  expect([sut class]).to.beSubclassOf([ALBaseCell class]);
}

#pragma mark - Dynamic Type Text - Tests

- (void)test___contentSizeCategoryDidChange___calls___AORefreshFont___on___textView
{
  // given
  id textView = OCMClassMock([UITextView class]);
  sut.textView = textView;
  
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  OCMExpect([textView setFont:font]);
  
  // when
  [sut contentSizeCategoryDidChange:nil];
  
  // then
  OCMVerifyAll(textView);
}

#pragma mark - Outlet Tests

- (void)test_has___textView
{
  expect(sut.textView).toNot.beNil();
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesDictionary___text
{
  // given
  NSString *text = @"This is some text";
  NSDictionary *dictionary = @{ALCellValueKey: text};
  
  // when
  [sut setValuesDictionary:dictionary];
  
  // then
  expect(sut.textView.text).to.equal(text);
}

- (void)test___setValuesDictionary___attributedText
{
  // given
  NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]};
  NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"This is some text" attributes:attributes];
  NSDictionary *dictionary = @{ALCellAttributedValueKey: text};
  
  // when
  [sut setValuesDictionary:dictionary];
  
  // then
  expect(sut.textView.attributedText).to.equal(text);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeEmail
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeEmail)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeEmailAddress);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeName
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeName)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeWords);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeNoChecking
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNoChecking)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypePassword
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypePassword)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textView.secureTextEntry).to.beTruthy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeSentences
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeSentences)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeYes);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeYes);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeDefault)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

- (void)test___setValuesDictionary___textCellType___ALTextCellTypeNumber
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(ALTextCellTypeNumber)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeNone);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeNo);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeNumberPad);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeNo);
}

- (void)test___setValuesDictionary___textCellType___defaultsTo___ALTextCellTypeDefault
{
  // given
  NSDictionary *dict = @{ALTextCellTypeKey: @(NSIntegerMax)};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.textView.autocapitalizationType).to.equal(UITextAutocapitalizationTypeSentences);
  expect(sut.textView.autocorrectionType).to.equal(UITextAutocorrectionTypeDefault);
  expect(sut.textView.keyboardType).to.equal(UIKeyboardTypeDefault);
  expect(sut.textView.secureTextEntry).to.beFalsy();
  expect(sut.textView.spellCheckingType).to.equal(UITextSpellCheckingTypeDefault);
}

#pragma mark - ALTextViewHelperDelegate - Tests

- (void)test_conformsTo___ALTextViewHelperDelegate
{
  expect(sut).to.conformTo(@protocol(ALTextViewHelperDelegate));
}


#pragma mark - ALTextViewHelperDelegate - Text Change - Tests

- (void)test___textViewHelper___notifiesDelegateWhen___textViewWillBeginEditing
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewWillBeginEditing:sut.textView];
  
  // then
  [[delegate verify] cellWillBeginEditing:sut];
}

- (void)test___textViewHelper___notifiesDelegateWhen___textViewDidChange
{
  // given
  [self givenMockDelegate];
  [self givenMockText];
  
  OCMExpect([delegate cell:sut valueChanged:sut.textView.text]);
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewDidChange:sut.textView];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test___textViewHelper___textViewWillEndEditing___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  [self givenMockText];
  
  OCMExpect([delegate cell:sut willEndEditing:sut.textView.text]);
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewWillEndEditing:sut.textView];
  
  // then
  OCMVerifyAll(delegate);
}

- (void)test___textViewHelper___notifiesDelegateWhen___textViewDidEndEditing
{
  // given
  [self givenMockDelegate];
  [self givenMockText];
  
  OCMExpect([delegate cell:sut didEndEditing:sut.textView.text]);
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewDidEndEditing:sut.textView];
  
  // then
  OCMVerifyAll(delegate);
}

#pragma mark - ALTextViewHelperDelegate - Height Changes - Tests

- (void)test___textViewHelper___notifiesDelegateWhen____textView_willChangeHeight_toHeight
{
  // given
  [self givenMockDelegate];
  CGFloat oldHeight = 10.0f;
  CGFloat newHeight = 15.0f;
  
  // when
  [sut textViewHelper:sut.textViewHelper
             textView:sut.textView
 willChangeFromHeight:oldHeight toHeight:newHeight];
  
  // then
  [[delegate verify] cell:sut
                 textView:sut.textView
     willChangeFromHeight:oldHeight
                 toHeight:newHeight];
}

- (void)test___textViewHelper___notifiesDelegateWhen___textView_didChangeHeight_toHeight
{
  // given
  [self givenMockDelegate];
  CGFloat oldHeight = 10.0f;
  CGFloat newHeight = 15.0f;
  
  // when
  [sut textViewHelper:sut.textViewHelper
             textView:sut.textView
  didChangeFromHeight:oldHeight toHeight:newHeight];
  
  // then
  [[delegate verify] cell:sut
                 textView:sut.textView
      didChangeFromHeight:oldHeight
                 toHeight:newHeight];
}

@end