//
//  UIImageView+ALImageWithURL.m
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

#import "UIImageView+ALImageWithURL.h"

#import <objc/runtime.h>

#import "ALImageCache.h"
#import "UIImageView+ALActivityIndicatorView.h"

char const ALImageDownloadTaskKey;

@implementation UIImageView (ALImageWithURL)

#pragma mark - Class Methods

+ (NSURLSession *)AL_sharedImageDownloadSession
{
  static NSURLSession *sharedImageDownloadSession = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sharedImageDownloadSession = [NSURLSession sessionWithConfiguration:configuration];
  });
  
  return sharedImageDownloadSession;
}

+ (ALImageCache *)AL_sharedImageDownloadCache
{
  static ALImageCache *sharedImageDownloadCache = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedImageDownloadCache = [[ALImageCache alloc] init];
  });
  
  return sharedImageDownloadCache;
}

#pragma mark - Custom Accessors

#pragma mark - AL_downloadTask

- (NSURLSessionDownloadTask *)AL_downloadTask
{
  return objc_getAssociatedObject(self, &ALImageDownloadTaskKey);
}

- (void)AL_setDownloadTask:(NSURLSessionDownloadTask *)task
{
  objc_setAssociatedObject(self, &ALImageDownloadTaskKey, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Instance Methods

- (void)AL_setImageWithURL:(NSURL *)url
               placeholder:(UIImage *)placeholder
    activityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
  [self.AL_downloadTask cancel];
  
  if (!url.absoluteString.length) {
    self.image = nil;
    return;
  }
  
  ALImageCache *cache = [[self class ] AL_sharedImageDownloadCache];
  self.image = [cache cachedImageForURL:url];
  
  if (!self.image) {
    self.image = placeholder;
    [[self AL_addActivityIndicatorViewWithStyle:style] startAnimating];
    [self AL_setImageDownloadTaskWithURL:url];
  }
}

- (void)AL_setImageDownloadTaskWithURL:(NSURL *)url
{
  __weak typeof(self) weakSelf = self;
  
  NSURLSessionDownloadTask *task = [[[self class] AL_sharedImageDownloadSession]
                                    downloadTaskWithURL:url
                                    completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                      
                                      __strong typeof(self) strongSelf = weakSelf;
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [[strongSelf AL_activityIndicatorView] stopAnimating];
                                        [strongSelf AL_setDownloadTask:nil];
                                        
                                        if (error) {
                                          return;
                                        }
                                        
                                        NSData *data = [NSData dataWithContentsOfURL:location];
                                        UIImage *image = [UIImage imageWithData:data];
                                        
                                        ALImageCache *cache = [[strongSelf class] AL_sharedImageDownloadCache];
                                        [cache cacheImage:image forURL:url];
                                        
                                        strongSelf.image = image;
                                        [strongSelf setNeedsDisplay];
                                        [strongSelf layoutIfNeeded];                                        
                                      });
                                    }];
  [task resume];
  [self AL_setDownloadTask:task];
}

@end
