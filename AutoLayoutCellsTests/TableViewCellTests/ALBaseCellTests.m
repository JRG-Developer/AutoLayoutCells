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
#import <AOTestCase/AOTestCase.h>
#import <objc/runtime.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

const char ALBaseCellCommonInitKey;

@interface ALBaseCell (Test_Methods)
@end

@implementation ALBaseCell (Test_Methods)

@end

@interface ALBaseCellTests : AOTestCase
@end

@implementation ALBaseCellTests
{
  ALBaseCell *sut;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[ALBaseCell alloc] init];
}

#pragma mark - Given

- (void)givenPartialMock
{
  partialMock = OCMPartialMock(sut);
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithCoder___calls___commonInit
{
  // given
  sut = [ALBaseCell alloc];
  [self givenPartialMock];
  
  // when
  sut = [sut initWithCoder:nil];
  
  // then
  [[partialMock verify] commonInit];
}

- (void)test___initWithStyle___calls___commonInit
{
  // given
  sut = [ALBaseCell alloc];
  [self givenPartialMock];
  
  // when
  
  sut = [sut initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
  // then
  [[partialMock verify] commonInit];
}

#pragma mark - Notification - Tests

- (void)test___commonInit___registersFor___UIContentSizeCategoryDidChangeNotification
{
  // given
  [self givenPartialMock];
  id notificationCenter = OCMClassMock([NSNotificationCenter class]);
  OCMStub([partialMock notificationCenter]).andReturn(notificationCenter);
  
  // when
  [sut commonInit];
  
  // then
  [[notificationCenter verify] addObserver:sut
                                  selector:@selector(contentSizeCategoryDidChange:)
                                      name:UIContentSizeCategoryDidChangeNotification
                                    object:nil];
}

@end