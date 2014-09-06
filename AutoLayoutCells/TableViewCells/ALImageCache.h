//
//  ALImageCache.h
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
 *  `ALImageCache` is a simple subclass of `NSCache`, which handles URL validation, adding/removing images by URL, and purging the cache on receiving `UIApplicationDidReceiveMemoryWarningNotification`.
 */
@interface ALImageCache : NSCache

/**
 *  This method returns the cached image for the URL or `nil` if no image exists within the cache.
 *
 *  @param url The URL for the image
 *
 *  @return The cached image for the URL or `nil`
 */
- (UIImage *)cachedImageForURL:(NSURL *)url;

/**
 *  This method adds the `image` to the cache if it's not nil and `url` has an absolute string length > 0 (i.e. it's valid).
 *
 *  Otherwise, if the image is `nil` and `url` is valid, the `image` is removed from the cache.
 *
 *  @param image The image to be added to the cache or `nil` to remove a cached image for the given URL
 *  @param url   The URL for the image
 */
- (void)cacheImage:(UIImage *)image forURL:(NSURL *)url;

@end