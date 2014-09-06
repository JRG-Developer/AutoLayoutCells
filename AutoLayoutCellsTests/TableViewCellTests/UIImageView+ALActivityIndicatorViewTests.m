//
//  UIImageView+ALActivityIndicatorViewTests.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/6/14.
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
#import "UIImageView+ALActivityIndicatorView.h"

// Collaborators
#import <objc/runtime.h>

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface UIImageView_ALActivityIndicatorViewTests : XCTestCase
@end

@implementation UIImageView_ALActivityIndicatorViewTests
{
  UIImageView *sut;
  id partialMock;
  
  UIImage *image;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  sut = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 500.0f, 500.0f)];
  partialMock = OCMPartialMock(sut);
  
  image = [[UIImage alloc] init];
}

#pragma mark - Tests

#pragma mark - AL_activityIndicatorView

- (void)test___AL_activityIndicatorView___returns_associated_indicator
{
  // given
  UIActivityIndicatorView *expected = [[UIActivityIndicatorView alloc] init];
  objc_setAssociatedObject(sut, &ALActivityIndicatorKey, expected, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  // when
  UIActivityIndicatorView *actual = [sut AL_activityIndicatorView];
  
  // then
  expect(actual).to.equal(expected);
}

#pragma mark - AL_addActivityIndicatorViewWithStyle:

- (void)test___AL_addActivityIndicatorViewWithStyle___removesIndicatorIfStyleIsInvalid
{
  // given
  UIActivityIndicatorView *indicator = OCMClassMock([UIActivityIndicatorView class]);
  objc_setAssociatedObject(sut, &ALActivityIndicatorKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  // when
  [sut AL_addActivityIndicatorViewWithStyle:NSNotFound];
  UIActivityIndicatorView *actual = objc_getAssociatedObject(sut, &ALActivityIndicatorKey);
  
  // then
  OCMVerify([indicator removeFromSuperview]);
  expect(actual).to.beNil();
}

- (void)test___AL_addActivityIndicatorViewWithStyle___associatesActivityIndicatorView
{
  // when
  UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
  UIActivityIndicatorView *actual = [sut AL_addActivityIndicatorViewWithStyle:style];
  UIActivityIndicatorView *expected = objc_getAssociatedObject(sut, &ALActivityIndicatorKey);
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___AL_addActivityIndicatorViewWithStyle___setsUpActivityIndicatorView
{
  // given
  UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
  
  // when
  UIActivityIndicatorView *actual = [sut AL_addActivityIndicatorViewWithStyle:style];
  
  // then
  expect(actual.activityIndicatorViewStyle).to.equal(style);
  expect(actual.autoresizingMask).to.equal([self expectedAutoResizingMask]);
  expect(actual.center).to.equal(sut.center);
  expect(actual.hidesWhenStopped).to.equal(YES);
  expect(actual.userInteractionEnabled).to.equal(NO);
  expect(actual.superview).to.equal(sut);
}

- (UIViewAutoresizing)expectedAutoResizingMask
{
  return UIViewAutoresizingFlexibleTopMargin    |
         UIViewAutoresizingFlexibleBottomMargin |
         UIViewAutoresizingFlexibleLeftMargin   |
         UIViewAutoresizingFlexibleRightMargin;
}

- (void)test___AL_addActivityIndicatorViewWithStyle___returnsAssociatedIndicatorIfSameStyle
{
  // given
  UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleWhiteLarge;
  UIActivityIndicatorView *expected = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
  objc_setAssociatedObject(sut, &ALActivityIndicatorKey, expected, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  // when
  UIActivityIndicatorView *actual = [sut AL_addActivityIndicatorViewWithStyle:style];
  
  // then
  expect(actual).to.equal(expected);
}

#pragma mark - AL_removeActivityIndicatorView

- (void)test___AL_removeActivityIndicatorView___removesActivityIndicatorView
{
  // given
  UIActivityIndicatorView *indicator = OCMClassMock([UIActivityIndicatorView class]);
  objc_setAssociatedObject(sut, &ALActivityIndicatorKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  // when
  [sut AL_removeActivityIndicatorView];
  UIActivityIndicatorView *actual = objc_getAssociatedObject(sut, &ALActivityIndicatorKey);
  
  // then
  OCMVerify([indicator removeFromSuperview]);
  expect(actual).to.beNil();
}

@end