//
//  ALImageCacheTests.m
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
#import "ALImageCache.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALImageCacheTests : XCTestCase
@end

@implementation ALImageCacheTests
{
  ALImageCache *sut;
  id partialMock;

  UIImage *image;
  NSURL *url;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];

  sut = [[ALImageCache alloc] init];
  partialMock = OCMPartialMock(sut);
  
  image = [[UIImage alloc] init];
  url = [NSURL URLWithString:@"http://example.com/image.jpg"];
}

#pragma mark - Object Lifecycle - Tests

- (void)test___init___registersFor_UIApplicationDidReceiveMemoryWarningNotification
{
  // given
  id mockCenter = OCMPartialMock([NSNotificationCenter defaultCenter]);
  
  // when
  sut = [[ALImageCache alloc] init];
  
  // then
  OCMVerify([mockCenter addObserver:[OCMArg any]
                           selector:@selector(removeAllObjects)
                               name:UIApplicationDidReceiveMemoryWarningNotification
                             object:nil]);
  
  // clean up
  [mockCenter stopMocking];
}

#pragma mark - Instance Methods

#pragma mark - cachedImageForURL:

- (void)test___cachedImageForURL___calls_objectForKey
{
  // given
  OCMStub([partialMock objectForKey:url.absoluteString]).andReturn(image);
  
  // when
  UIImage *actualImage = [sut cachedImageForURL:url];
  
  // then
  expect(actualImage).to.equal(image);
}

#pragma mark - cacheImage:forURL:

- (void)test___cacheImage_forURL___returnsIfURLNotValid
{
  // given
  [[partialMock reject] removeObjectForKey:[OCMArg any]];
  [[partialMock reject] setObject:[OCMArg any] forKey:[OCMArg any]];
  
  // when
  [sut cacheImage:image forURL:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___cacheImage_forURL___removesImage_ifImageIsNil
{
  // when
  [sut cacheImage:nil forURL:url];
  
  // then
  OCMVerify([partialMock removeObjectForKey:url.absoluteString]);
}

- (void)test___cacheImage_forURL___cachesImage_ifImageAndURLAreValid
{
  // when
  [sut cacheImage:image forURL:url];
  
  // then
  OCMVerify([partialMock setObject:image forKey:url.absoluteString]);
}

@end