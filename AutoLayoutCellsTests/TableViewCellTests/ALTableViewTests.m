//
//  ALTableViewTests.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/5/14.
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
#import "ALTableView.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALTableViewTests : XCTestCase
@end

@implementation ALTableViewTests
{
  ALTableView *sut;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[ALTableView alloc] init];
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithCoder___calls_commonInit
{
  // given
  NSMutableData *data = [[NSMutableData alloc] init];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver finishEncoding];
  NSCoder *coder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  sut = [ALTableView alloc];
  partialMock = OCMPartialMock(sut);
  
  // when
  sut = [sut initWithCoder:coder];
  
  // then
  OCMVerify([partialMock commonInit]);
}

- (void)test___initWithFrame_style___calls_commonInit
{
  // given
  sut = [ALTableView alloc];
  partialMock = OCMPartialMock(sut);
  
  // when
  sut = [sut initWithFrame:CGRectZero style:UITableViewStylePlain];
  
  // then
  OCMVerify([partialMock commonInit]);
}

- (void)test___commonInit___registersFor_UIContentSizeCategoryDidChangeNotification
{
  // given
  id mockCenter = OCMPartialMock([NSNotificationCenter defaultCenter]);
  
  // when
  sut = [[ALTableView alloc] init];
  
  // then
  OCMVerify([mockCenter addObserver:sut
                           selector:@selector(contentSizeCategoryDidChange:)
                               name:UIContentSizeCategoryDidChangeNotification
                             object:nil]);
  
  // clean up
  [mockCenter stopMocking];
}

#pragma mark - Notifications - Tests

- (void)test___contentSizeCategoryDidChange___calls_reloadData
{
  // given
  partialMock = OCMPartialMock(sut);
  OCMExpect([partialMock reloadData]);
  
  // when
  [sut contentSizeCategoryDidChange:nil];
  
  // then
  OCMVerifyAllWithDelay(partialMock, 0.01);
}

@end