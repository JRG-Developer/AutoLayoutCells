//
//  UIImageView+AutoLayoutCells.h
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

/**
 *  `UIImageView+AutoLayoutCells` provides convenience methods for setting an image from a URL, including basic image caching.
 */
@interface UIImageView (AutoLayoutCells)

///--------------------------------------------------------------
/// @name Associated Properties
///--------------------------------------------------------------

/**
 *  The download session data task
 *
 *  @discussion Calling `AL_setImageWithURL:placeholder:` or `AL_setImageWithURLRequest:placeholder:` creates a new session download task and associates it with the image view.
 */
@property (strong, nonatomic, readonly) NSURLSessionDownloadTask *AL_downloadTask;

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
 *  @discussion THis methods uses `dispatch_once` to create the shared image download cache.
 *
 *  @return The shared image download cache
 */
+ (NSCache *)AL_imageDownloadCache;

///--------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------

/**
 *  Use this method to set the image from a given URL with an optional placeholder image.
 *
 *  @param url                  The url to set the image
 *  @param placeholder          The image placeholder to be set while the image is loading
 *  @param showLoadingIndicator Whether a loading activity indicator should be shown while the image is loading
 */
- (void)AL_setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder;

/**
 *  Use this method to set the image from a given URL showing an activity indicator with the given style.
 *
 *  @param url   The url to set the image
 *  @param style THe activity indicator style
 */
- (void)AL_setImageWithURL:(NSURL *)url activityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

@end
