//
//  ALBaseCellTests.m
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
#import "ALBaseCell.h"
#import "ALCellConstants.h"

// Collaborators

// Test Support
#import <XCTest/XCTestCase.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALBaseCell (Test_Methods)
@end

@implementation ALBaseCell (Test_Methods)

@end

@interface ALBaseCellTests : XCTestCase
@end

@implementation ALBaseCellTests
{
  ALBaseCell *sut;

  id notificationCenter;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[ALBaseCell alloc] init];
}

- (void)tearDown
{
  [notificationCenter stopMocking];
  [partialMock stopMocking];
  [super tearDown];
}

#pragma mark - Given - Mocks

- (void)givenMockNotificationCenter
{
  notificationCenter = OCMClassMock([NSNotificationCenter class]);
  OCMStub([notificationCenter defaultCenter]).andReturn(notificationCenter);
}

- (void)givenPartialMock
{
  partialMock = OCMPartialMock(sut);
}

#pragma mark - Class Configuration - Tests

- (void)test___shouldRegisterForFontChanges___defaultsTo_YES
{
  expect([ALBaseCell shouldRegisterForFontChanges]).to.beTruthy();
}

- (void)test___setShouldRegisterForFontChanges___sets_shouldRegisterForFontChanges {
  
  // given
  BOOL expected = NO;
  
  // when
  [ALBaseCell setShouldRegisterForFontChanges:expected];
  BOOL actual = [ALBaseCell shouldRegisterForFontChanges];
  
  // then
  expect(actual).to.equal(expected);
  
  // clean
  [ALBaseCell setShouldRegisterForFontChanges:YES];
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithCoder___calls___commonInit
{
  // given
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver finishEncoding];
    NSCoder *coder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  sut = [ALBaseCell alloc];

  [self givenPartialMock];
  OCMExpect([partialMock commonInit]);
  
  // when
  sut = [sut initWithCoder:coder];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithStyle___calls___commonInit
{
  // given
  sut = [ALBaseCell alloc];

  [self givenPartialMock];
  OCMExpect([partialMock commonInit]);
  
  // when
  
  sut = [sut initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

#pragma mark - Notification - Tests

- (void)test___commonInit___givenShouldRegisterForFontChanges_YES_thenRegistersFor___UIContentSizeCategoryDidChangeNotification
{
  // given
  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter addObserver:sut
                                   selector:@selector(contentSizeCategoryDidChange:)
                                       name:UIContentSizeCategoryDidChangeNotification
                                     object:nil]);
  
  // when
  [sut commonInit];
  
  // then
  OCMVerifyAll(notificationCenter);
}

- (void)test___commonInit___givenShouldRegisterForFontChanges_NO_doesNotRegisterFor____UIContentSizeCategoryDidChangeNotification
{
  // given
  [ALBaseCell setShouldRegisterForFontChanges:NO];
  
  [self givenMockNotificationCenter];
  SEL selector = NULL;
  [[[notificationCenter reject] ignoringNonObjectArgs] addObserver:sut selector:selector name:OCMOCK_ANY object:OCMOCK_ANY]; // yeah, I hacked that... ;P
  
  // when
  [sut commonInit];
  
  // then
  OCMVerifyAll(notificationCenter);
  
  // clean up
  [ALBaseCell setShouldRegisterForFontChanges:YES];
}

@end
