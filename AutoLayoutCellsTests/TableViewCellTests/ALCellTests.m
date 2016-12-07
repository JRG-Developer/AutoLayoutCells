//
//  ALCellTests.m
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
#import "ALCell.h"
#import "ALCellConstants.h"

// Collaborators
#import "ALTableViewCellNibFactory.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALCellTests : XCTestCase
@end

@implementation ALCellTests
{
  ALCell *sut;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  sut = [ALTableViewCellNibFactory cellWithName:@"ALCell" owner:self];
  [super setUp];
}

#pragma mark - Utilities

- (NSDictionary *)valuesDictionary
{
  return @{ALCellTitleKey: @"This is the title string",
           ALCellSubtitleKey: @"This is the subtitle string"};
}

- (NSDictionary *)attributedValuesDictionary
{
  NSString *title = @"This is the title string";
  NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
  [attTitle setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}
                    range:NSMakeRange(0, title.length)];
  
  NSString *subtitle = @"This is the subtitle string";
  NSMutableAttributedString *attSubtitle = [[NSMutableAttributedString alloc] initWithString:subtitle];
  [attSubtitle setAttributes:@{NSObliquenessAttributeName: @(1)}
                       range:NSMakeRange(0, subtitle.length)];
  
  return @{ALCellAttributedTitleKey: attTitle,
           ALCellAttributedSubtitleKey: attSubtitle};
}

#pragma mark - Class - Tests

- (void)test_subclassOf___ALBaseCell
{
  expect([sut class]).to.beSubclassOf([ALBaseCell class]);
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

#pragma mark - Dynamic Type Text - Tests

- (void)test___contentSizeCategoryDidChange___calls___setFont___on___titleLabel
{
  // given
  NSNotification *notification = [NSNotification notificationWithName:UIContentSizeCategoryDidChangeNotification
                                                               object:nil];
  
  id label = OCMClassMock([ALLabel class]);
  sut.titleLabel = label;
  
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
  OCMExpect([label setFont:font]);
  
  // when
  [sut contentSizeCategoryDidChange:notification];
  
  // then
  OCMVerifyAll(label);
}

- (void)test___contentSizeCategoryDidChange___calls___AORefreshFont___on___subtitleLabel
{
  // given
  NSNotification *notification = [NSNotification notificationWithName:UIContentSizeCategoryDidChangeNotification
                                                               object:nil];
  id label = OCMClassMock([ALLabel class]);
  sut.subtitleLabel = label;
  
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
  OCMExpect([label setFont:font]);
  
  // when
  [sut contentSizeCategoryDidChange:notification];
  
  // then
  OCMVerifyAll(label);
}

#pragma mark - Set Values Dictionary - Tests

- (void)test___setValuesFromDictionary___titleString
{
  // given
  NSDictionary *dictionary = [self valuesDictionary];
  NSString *title = dictionary[ALCellTitleKey];
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.titleLabel.text).to.equal(title);
}

- (void)test___setValuesFromDictionary___attributedTitleString
{
  // given
  NSDictionary *dictionary = [self attributedValuesDictionary];
  NSAttributedString *title = dictionary[ALCellAttributedTitleKey];
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.titleLabel.attributedText).to.equal(title);
}

- (void)test___setValuesFromDictionary___titleString_setsNilIfTitleStringIsEmpty
{
  // given
  sut.titleLabel.text = @"Some existing title string";
  NSDictionary *dictionary = @{ALCellTitleKey: @""};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.titleLabel.text).to.beNil();
}

- (void)test___setValuesFromDictionary____titleString_setsEmptyStringIfAttributedTitleStringIsEmpty
{
  // given
  NSString *string = @"Some existing title string";
  sut.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:string];
  NSDictionary *dictionary = @{ALCellAttributedTitleKey: @""};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.titleLabel.attributedText).to.beNil();
}

- (void)test___setValuesFromDictionary___subtitleString
{
  // given
  NSDictionary *dictionary = [self valuesDictionary];
  NSString *subtitle = dictionary[ALCellSubtitleKey];
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.subtitleLabel.text).to.equal(subtitle);
}

- (void)test___setValuesFromDictionary___attributedSubtitleString
{
  // given
  NSDictionary *dictionary = [self attributedValuesDictionary];
  NSAttributedString *subtitle = dictionary[ALCellAttributedSubtitleKey];
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.subtitleLabel.attributedText).to.equal(subtitle);
}

- (void)test___setValuesFromDictionary___subtitleString_setsNilIfSubtitleStringIsEmpty
{
  // given
  sut.subtitleLabel.text = @"Some existing title string";
  NSDictionary *dictionary = @{ALCellSubtitleKey: @""};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.subtitleLabel.text).to.beNil();
}

- (void)test___setValuesFromDictionary___subtitleString_setsEmptyStringIfAttributedSubtitleStringIsEmpty
{
  // given
  NSString *string = @"Some existing title string";
  sut.subtitleLabel.attributedText = [[NSAttributedString alloc] initWithString:string];
  NSDictionary *dictionary = @{ALCellAttributedSubtitleKey: @""};
  
  // when
  [sut setValuesFromDictionary:dictionary];
  
  // then
  expect(sut.subtitleLabel.attributedText).to.beNil();
}

@end
