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

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

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

- (void)givenMockTextField
{
  mockTextField = OCMPartialMock(textField);
}

- (void)givenMockDelegate
{
  delegate = OCMProtocolMock(@protocol(ALCellDelegate));
}

#pragma mark - Object Lifecycle - Tests

- (void)test___initWithCell_textField___setsInstanceProperties
{
  expect(sut.cell).to.equal(cell);
  expect(sut.textField).to.equal(textField);
}

- (void)test___initWithCell_textField___sets_textField_delegate
{
  expect(textField.delegate).to.equal(sut);
}

@end