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
#import <UIImageView+ALActivityIndicatorView/UIImageView+ALActivityIndicatorView.h>

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
  
  id mockTask;
  id mockSession;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  
  sut = [[UIImageView alloc] init];
  image = [[UIImage alloc] init];
  url = [NSURL URLWithString:@"http://example.com/image.jpg"];
}

- (void)tearDown
{
  [partialMock stopMocking];
  [[UIImageView AL_sharedImageDownloadCache] removeAllObjects];
  
  [super tearDown];
}

#pragma mark - Given

- (void)givenImageDownloadTaskCompletesWithLocation:(NSURL *)location
                                           response:(NSURLResponse *)response
                                              error:(NSError *)error
{
  partialMock = OCMPartialMock(sut);
  [self givenMockSessionWithLocation:location response:response error:error];
  OCMStub([partialMock AL_sharedImageDownloadSession]).andReturn(mockSession);
}

- (void)givenMockSessionWithLocation:(NSURL *)location
                            response:(NSURLResponse *)response
                               error:(NSError *)error
{
  mockTask = OCMClassMock([NSURLSessionDownloadTask class]);
  mockSession = OCMClassMock([NSURLSession class]);
  
  OCMStub([mockSession downloadTaskWithURL:[OCMArg any]
                         completionHandler:[OCMArg any]])
  .andReturn(mockTask)
  .andDo(^(NSInvocation *invocation) {
    
    void (^completion)(NSURL *, NSURLResponse *, NSError *);
    [invocation getArgument:&completion atIndex:3];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      completion(location, response, error);
    });
  });
}

- (NSURL *)locationForTestImage
{
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  return [bundle URLForResource:@"test_image" withExtension:@"png"];
}

- (UIImage *)testImage
{
  NSURL *location = [self locationForTestImage];
  NSData *data = [NSData dataWithContentsOfURL:location];
  return [UIImage imageWithData:data];
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

#pragma mark - Custom Accessor - Tests

- (void)test___setImage___cancelsDownloadTask
{
  // given
  mockTask = OCMClassMock([NSURLSessionDownloadTask class]);
  objc_setAssociatedObject(sut, &ALImageDownloadTaskKey, mockTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  OCMExpect([mockTask cancel]);
  
  // when
  [sut setImage:image];
  
  // then
  OCMVerifyAll(mockTask);
}

- (void)test___AL_downloadTask___returnsAssociatedTask
{
  // given
  mockTask = OCMClassMock([NSURLSessionDownloadTask class]);
  objc_setAssociatedObject(sut, &ALImageDownloadTaskKey, mockTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  // when
  NSURLSessionTask *actualTask = [sut AL_downloadTask];
  
  // then
  expect(actualTask).to.equal(mockTask);
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
  partialMock = OCMPartialMock(sut);
  
  UIActivityIndicatorViewStyle style = UIActivityIndicatorViewStyleGray;
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

- (void)test___AL_startImageDownloadTaskWithURL___completionStopsIndicator
{
  // given
  [self givenImageDownloadTaskCompletesWithLocation:nil response:nil error:nil];
  
  id mockIndicator = OCMClassMock([UIActivityIndicatorView class]);
  OCMStub([partialMock AL_activityIndicatorView]).andReturn(mockIndicator);
  
  OCMExpect([mockIndicator stopAnimating]);
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  OCMVerifyAllWithDelay(mockIndicator, 0.01);
}

- (void)test___AL_startImageDownloadTaskWithURL___completionNilsDownloadTask
{
  // given
  [self givenImageDownloadTaskCompletesWithLocation:nil response:nil error:nil];
    
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  expect(sut.AL_downloadTask).will.beNil();
}

- (void)test___AL_startImageDownloadTaskWithURL___completionCachesImage
{
  // given
  image = [self testImage];
  NSURL *location = [self locationForTestImage];
  [self givenImageDownloadTaskCompletesWithLocation:location response:nil error:nil];
  
  ALImageCache *cache = [UIImageView AL_sharedImageDownloadCache];
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  expect(UIImagePNGRepresentation([cache cachedImageForURL:url])).will.equal(UIImagePNGRepresentation(image));
}

- (void)test___AL_startImageDownloadTaskWithURL___completionSetsImageFromLocation
{
  // given
  image = [self testImage];
  NSURL *location = [self locationForTestImage];
  [self givenImageDownloadTaskCompletesWithLocation:location response:nil error:nil];
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  expect(UIImagePNGRepresentation(sut.image)).will.equal(UIImagePNGRepresentation(image));
}

- (void)test___AL_startImageDownloadTaskWithURL___completionErrorDoesNotSetImage
{
  // given
  NSError *error = [NSError errorWithDomain:@"com.jrgdeveloper.ALImageWithURL" code:0 userInfo:nil];
  [self givenImageDownloadTaskCompletesWithLocation:nil response:nil error:error];
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  expect(sut.image).will.beNil();
}

- (void)test___AL_startImageDownloadTaskWithURL___completionErrorDoesNotCacheImage
{
  // given
  NSError *error = [NSError errorWithDomain:@"com.jrgdeveloper.ALImageWithURL" code:0 userInfo:nil];
  [self givenImageDownloadTaskCompletesWithLocation:nil response:nil error:error];
  
  id mockCache = OCMClassMock([ALImageCache class]);
  OCMStub([partialMock AL_sharedImageDownloadCache]).andReturn(mockCache);
  
  [[mockCache reject] cacheImage:[OCMArg any] forURL:[OCMArg any]];
  
  // when
  [sut AL_setImageWithURL:url placeholder:nil activityIndicatorStyle:NSNotFound];
  
  // then
  OCMVerifyAllWithDelay(mockCache, 0.01);
}

@end