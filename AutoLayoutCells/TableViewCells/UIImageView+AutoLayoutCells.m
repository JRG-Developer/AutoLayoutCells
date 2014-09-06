//
//  UIImageView+AutoLayoutCells.m
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

#import "UIImageView+AutoLayoutCells.h"
#import <objc/runtime.h>

char const ALImageCellKey;
char const ALActivityIndicatorKey;

@implementation UIImageView (AutoLayoutCells)

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

+ (NSCache *)AL_imageDownloadCache
{
  static NSCache *sharedImageDownloadCache = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedImageDownloadCache = [[NSCache alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * notification) {
                                                    [sharedImageDownloadCache removeAllObjects];
                                                  }];
  });
  
  return sharedImageDownloadCache;
}

#pragma mark - Custom Accessors

#pragma mark - AL_downloadTask

- (NSURLSessionDownloadTask *)AL_downloadTask
{
  return objc_getAssociatedObject(self, &ALImageCellKey);
}

- (void)AL_setDownloadTask:(NSURLSessionDownloadTask *)task
{
  NSURLSessionDownloadTask *currentTask = [self AL_downloadTask];
  if (currentTask == task) {
    return;
  }
  
  [currentTask cancel];
  objc_setAssociatedObject(self, &ALImageCellKey, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - AL_activityIndicatorView

- (UIActivityIndicatorView *)AL_activityIndicatorView
{
  return objc_getAssociatedObject(self, &ALActivityIndicatorKey);
}

- (UIActivityIndicatorView *)AL_activityIndicatorViewWithStyle:(UIActivityIndicatorViewStyle)style
{
  return objc_getAssociatedObject(self, &ALActivityIndicatorKey) ?: [self AL_setupActivityIndicatorWithStyle:style];
}

- (UIActivityIndicatorView *)AL_setupActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)style
{
  UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
  activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin |
                                       UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  activityIndicator.center = self.center;
  activityIndicator.hidesWhenStopped = YES;
  activityIndicator.userInteractionEnabled = NO;
  
  [self addSubview:activityIndicator];
  objc_setAssociatedObject(self, &ALActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
  return activityIndicator;
}

#pragma mark - Instance Methods

- (void)AL_setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder
{
  if (!url) {
    self.image = nil;
    return;
  }
  
  @synchronized (self) {
    
    self.image = [self AL_cachedImageForURL:url];
    
    if (!self.image) {
      self.image = placeholder;
      [self AL_setImageDownloadTaskWithURL:url];
    }
  }
}

- (void)AL_setImageWithURL:(NSURL *)url activityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
  if (!url) {
    self.image = nil;
    return;
  }
  
  @synchronized (self) {
    
    self.image = [self AL_cachedImageForURL:url];
    
    if (!self.image) {
      [[self AL_activityIndicatorViewWithStyle:style] startAnimating];
      [self AL_setImageDownloadTaskWithURL:url];
    }
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
                                        [strongSelf AL_cacheImage:image forURL:url];
                                        
                                        strongSelf.image = image;
                                        [strongSelf setNeedsDisplay];
                                        [strongSelf layoutIfNeeded];                                        
                                      });
                                    }];
  [task resume];
  [self AL_setDownloadTask:task];
}

#pragma mark - Image Caching

- (UIImage *)AL_cachedImageForURL:(NSURL *)url
{
  NSCache *cache = [[self class] AL_imageDownloadCache];
  return [cache objectForKey:url.absoluteString];
}

- (void)AL_cacheImage:(UIImage *)image forURL:(NSURL *)url
{
  NSCache *cache = [[self class] AL_imageDownloadCache];
  
  if (!url.absoluteString.length) {
    return;
    
  } else if (!image) {
    [cache removeObjectForKey:url.absoluteString];
    
  } else {
    [cache setObject:image forKey:url.absoluteString];
  }
}

@end
