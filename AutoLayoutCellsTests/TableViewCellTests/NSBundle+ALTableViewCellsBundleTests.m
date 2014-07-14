//
//  NSBundle+ALTableViewCellsBundleTests
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
#import "NSBundle+ALTableViewCellsBundle.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>
#import <objc/runtime.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface NSBundle (Test_ALTableViewCellsBundle)

+ (NSBundle *)test_mainBundle;

@end

@implementation NSBundle (Test_ALTableViewCellsBundle)

+ (NSBundle *)test_mainBundle
{
  return [NSBundle bundleForClass:[self class]];
}

@end

@interface NSBundle_ALTableViewCellsBundleTests : XCTestCase
@end

@implementation NSBundle_ALTableViewCellsBundleTests

#pragma mark - Runtime Swaps

- (void)swap_mainBundle
{
  Method m1 = class_getClassMethod([NSBundle class], @selector(mainBundle));
  Method m2 = class_getClassMethod([NSBundle class], @selector(test_mainBundle));
  method_exchangeImplementations(m1, m2);
}

#pragma mark - Tests

- (void)test___pathForALTableViewCellsBundle___returnsExpectedPath
{
  // given
  [self swap_mainBundle];
  NSBundle *classBundle = [NSBundle mainBundle];
  NSString *expectedPath = [[classBundle resourcePath] stringByAppendingPathComponent:ALTableViewCellsBundleName];
  
  // when
  NSString *actualPath = [NSBundle _pathForALTableViewCellsBundle];
  
  // then
  expect(expectedPath).toNot.beNil();
  expect(actualPath).to.equal(expectedPath);
  
  // clean up
  [self swap_mainBundle];
}

@end