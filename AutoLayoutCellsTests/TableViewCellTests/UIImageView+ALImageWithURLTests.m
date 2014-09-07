//
//  UIImageView+ALImageWithURLTests.m
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
#import "UIImageView+ALImageWithURL.h"

// Collaborators
#import "ALImageCache.h"
#import "UIImageView+ALActivityIndicatorView.h"

// Test Support
#import <XCTest/XCTest.h>
#import <objc/runtime.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface UIImageView_ALImageWithURLTests : XCTestCase
@end

@implementation UIImageView_ALImageWithURLTests
{
  UIImageView *sut;
  id partialMock;
  
  UIImage *image;
  NSURL *url;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  sut = [[UIImageView alloc] init];
  
  image = [[UIImage alloc] init];
  url = [NSURL URLWithString:@"http://example.com/image.jpg"];
}

#pragma mark - Class Methods - Tests

- (void)test___AL_sharedImageDownloadSession___returnsSingleSharedSession
{
  // when
  NSURLSession *session1 = [UIImageView AL_sharedImageDownloadSession];
  NSURLSession *session2 = [UIImageView AL_sharedImageDownloadSession];
  
  // then
  expect(session1).to.equal(session2);
}

- (void)test___AL_sharedImageDownloadCache___returnsSingleSharedCache
{
  // when
  ALImageCache *cache1 = [UIImageView AL_sharedImageDownloadCache];
  ALImageCache *cache2 = [UIImageView AL_sharedImageDownloadCache];
  
  // then
  expect(cache1).to.equal(cache2);
}

#pragma mark - Instance Methods - Tests

- (void)test___setImageWithURL_placeholder_activityIndicatorStyle___cancelsCurrentTask
{
  // given
  id task = OCMClassMock([NSURLSessionDownloadTask class]);
  objc_setAssociatedObject(sut, &ALImageDownloadTaskKey, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  OCMVerify([task cancel]);
}

- (void)test___setImageWithURL_placeholder_activityIndicatorStyle___invalidURL_setsNilImageAndReturns
{
  // given
  sut.image = image;
  
  // when
  [sut AL_setImageWithURL:nil placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  expect(sut.image).to.beNil();
  expect([sut AL_downloadTask]).to.beNil();
}

- (void)test___setImageWithURL_placeholder_activityIndicatorStyle___setsImageFromCache
{
  // given
  ALImageCache *cache = [UIImageView AL_sharedImageDownloadCache];
  [cache cacheImage:image forURL:url];
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  expect(sut.image).to.equal(image);
  
  // clean up
  [cache removeAllObjects];
}

- (void)test___setImageWithURL_placeholder_activityIndicatorStyle___setsPlaceholderImage
{
  // when
  [sut AL_setImageWithURL:url placeholder:image activityIndicatorStyle:NSNotFound];
  
  // then
  expect(sut.image).to.equal(image);
  
  // clean up
  [[sut AL_downloadTask] cancel];
}

- (void)test___setImageWithURL_placeholder_activityIndicatorStyle___addsActivityIndicator
{
  // given
  UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
  
  partialMock = OCMPartialMock(sut);
  OCMExpect([partialMock AL_addActivityIndicatorViewWithStyle:style]);
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:style];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setImageWithURL_placeholder_activityIndicatorStyle___setsDownloadTask
{
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  NSURLSessionDownloadTask *task = [sut AL_downloadTask];
  
  // then
  expect(task).toNot.beNil();
}

@end