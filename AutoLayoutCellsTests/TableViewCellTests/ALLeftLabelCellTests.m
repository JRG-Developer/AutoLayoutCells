//
//  ALLeftLabelCell.m
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
#import "ALLeftLabelCell.h"
#import "ALLeftLabelCellConstants.h"

// Collaborators
#import "ALTableViewCellNibFactory.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALLeftLabelCellTests : XCTestCase
@end

@implementation ALLeftLabelCellTests
{
  ALLeftLabelCell *sut;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [ALTableViewCellNibFactory cellWithName:@"ALLeftLabelCell" owner:nil];
}

#pragma mark - Class - Tests

- (void)test_isSubclassOf_ALCell
{
  expect([sut class]).to.beSubclassOf([ALCell class]);
}

#pragma mark - Dynamic Type Text - Tests

- (void)test___contentSizeCategoryDidChange___calls___setFont___on___leftLabel
{
  // given
  id label = OCMClassMock([ALLabel class]);
  sut.leftLabel = label;
  
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
  
  OCMExpect([label setFont:font]);
  
  // when
  [sut contentSizeCategoryDidChange:nil];
  
  // then
  OCMVerifyAll(label);
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

- (void)test_has___leftLabel
{
  expect(sut.leftLabel).toNot.beNil();
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesFromDictionary___leftText
{
  // given
  NSString *text = @"Some Test Text";
  NSDictionary *dict = @{ALLeftLabelTextKey: text};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(sut.leftLabel.text).to.equal(text);
}

- (void)test___setValuesFromDictionary___attribtedLeftText
{
  // given
  NSString *text = @"Some Test Text";
  NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];
  NSDictionary *dict = @{ALLeftLabelAttributedTextKey: attributedText};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(sut.leftLabel.attributedText).to.equal(attributedText);
}

- (void)test___setValuesFromDictionary___emptyLeftLabelTextSets___leftLabel___textTonil
{
  // given
  NSString *text = @"";
  NSDictionary *dict = @{ALLeftLabelTextKey: text};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(sut.leftLabel.text).to.beNil();
}

- (void)test___setValuesFromDictionary___emptyAttributedLeftLabelTextSets___leftLabel___attributedTextToNil
{
  // given
  NSString *text = @"";
  NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];
  NSDictionary *dict = @{ALLeftLabelAttributedTextKey: attributedText};
  
  // when
  [sut setValuesFromDictionary:dict];
  
  // then
  expect(sut.leftLabel.attributedText).to.beNil();
}

@end