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
#import "ALTextCell.h"

// Collaborators
#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

#import "ALCellConstants.h"
#import "ALTextCellDelegate.h"
#import "ALTextCellConstants.h"
#import "ALTextViewHelper.h"
#import "Test_ALTableViewCellNibFactory.h"
#import "UIView+ALRefreshFont.h"

// Test Support
#import <XCTest/XCTest.h>
#import "ALCellConstants.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTextCellTests : XCTestCase
@end

@implementation ALTextCellTests
{
  ALTextCell *sut;
  id delegate;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [Test_ALTableViewCellNibFactory cellWithName:@"ALTextCell" owner:self];
}

- (NSDictionary *)valuesDictionary
{
  return @{};
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

- (void)test_subclassOf___ALImageCell
{
  expect([sut superclass]).to.beSubclassOf([ALImageCell class]);
}

#pragma mark - Dynamic Type Text - Tests

- (void)test___contentSizeCategoryDidChange___calls___AORefreshFont___on___textView
{
  // given
  id textView = OCMClassMock([ALAutoResizingTextView class]);
  sut.textView = textView;
  
  // when
  [sut contentSizeCategoryDidChange:nil];
  
  // then
  [[textView verify] AL_refreshPreferredFont];
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
  NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"This is some text"
                                                                 attributes:attributes];
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

- (void)test___textViewHelper___textViewWillBeginEditing___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewWillBeginEditing:sut.textView];
  
  // then
  [[delegate verify] cellWillBeginEditing:sut];
}

- (void)test___textViewHelper___textViewDidChange___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  [self givenMockText];
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewDidChange:sut.textView];
  
  // then
  [[delegate verify] cell:sut valueChanged:sut.textView.text];
}

- (void)test___textViewHelper___textViewDidEndEditing___notifiesDelegate
{
  // given
  [self givenMockDelegate];
  [self givenMockText];
  
  // when
  [sut textViewHelper:sut.textViewHelper textViewDidEndEditing:sut.textView];
  
  // then
  [[delegate verify] cell:sut didEndEditing:sut.textView.text];
}

#pragma mark - ALTextViewHelperDelegate - Height Changes - Tests

- (void)test___textViewHelper__notifiesDelegateWhen___textView_willChangeHeight_toHeight
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

- (void)test___textViewHelper___notifiesDelegateWhen___textView_didChangeFromHeight_toHeight
{
  // given
  [self givenMockDelegate];
  CGFloat oldHeight = 10.0f;
  CGFloat newHeight = 15.0f;
  
  // when
  [sut textViewHelper:sut.textViewHelper
             textView:sut.textView
  didChangeFromHeight:oldHeight
             toHeight:newHeight];
  
  // then
  [[delegate verify] cell:sut   
                 textView:sut.textView
      didChangeFromHeight:oldHeight
                 toHeight:newHeight];
}

@end