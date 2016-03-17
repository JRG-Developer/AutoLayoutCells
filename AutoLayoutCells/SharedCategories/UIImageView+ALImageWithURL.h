//
//  UIImageView+ALImageWithURL.h
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

@import UIKit;
@class ALImageCache;

/**
 *  The key used to associate the download task with the image view
 */
extern char const ALImageDownloadTaskKey;

/**
 *  `UIImageView+ALImageWithURL` provides a convenience methods for setting an image from a URL showing an optional placeholder and/or activity indicator view during loading. Basic image caching is provided too.
 */
@interface UIImageView (ALImageWithURL)

///--------------------------------------------------------------
/// @name Associated Properties
///--------------------------------------------------------------

/**
 *  The assocated download session data task
 */
@property (strong, nonatomic, readonly) NSURLSessionDownloadTask *AL_downloadTask;

/**
 *  The associated activity indicator view
 */
@property (strong, nonatomic, readonly) UIActivityIndicatorView *AL_activityIndicatorView;

///--------------------------------------------------------------
/// @name Class Methods
///--------------------------------------------------------------

/**
 *  This method returns the shared image download session, which is used for managing image downloading.
 *
 *  @discussion This method uses `dispatch_once` to create the shared image download session.
 *
 *  @return The shared image download session.
 */
+ (NSURLSession *)AL_sharedImageDownloadSession;

/**
 *  This method returns the shared image download cache.
 *
 *  @discussion This method uses `dispatch_once` to create the shared image download session.
 *
 *  @return The shared image download cache
 */
+ (ALImageCache *)AL_sharedImageDownloadCache;

///--------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------

/**
 *  Use this method to set the image from a given URL with an optional placeholder image and/or optional activity indicator.
 *
 *  @discussion If you don't want to show a placeholder, pass `nil` for `placeholder`. If you don't want to show an activity indicator, pass `NSNotFound` for `activityIndicatorStyle`.
 *
 *  @param url         The url to set the image
 *  @param placeholder The image placeholder to be set while the image is loading
 *  @param style       The activity indicator style to use create the activity indicator
 */
- (void)AL_setImageWithURL:(NSURL *)url
               placeholder:(UIImage *)placeholder
    activityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

@end
