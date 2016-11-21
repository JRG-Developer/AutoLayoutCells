//
//  ALImageCellConstants.h
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

#import "ALCellConstants.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Subclasses of `ALImageCell` use these keys to set the relevant text/values on their subviews.
 */

///--------------------------------------------------------------
/// @name Main Image Keys
///--------------------------------------------------------------

/**
 *  Use this key to specify an image to be set on the cell's `mainImageView`.
 */
extern NSString * const ALImageCellMainImageKey;                // mainImage

/**
 *  Use this key to specify an image name of an image within the main bundle to be set on the cell's `mainImageView`.
 */
extern NSString * const ALImageCellMainImageNameKey;            // mainImageName

/**
 *  Use this kety to specify a `UIColor` to be set as the `tintColor` on the cell's `mainImageView`.
 */
extern NSString * const ALImageCellMainImageTintColorKey;        // mainImageTintColor

/**
 *  Use this key to specify a URL string to be used to load the image to be set on the cell's `mainImageView`.
 */
extern NSString * const ALImageCellMainImageURLStringKey;       // mainImageURLString

/**
 *  Use this key to specify a `NSURL` to be used to load the image to be set on the cell's `mainImageView`.
 */
extern NSString * const ALImageCellMainImageURLKey;             // mainImageURL

/**
 *  Use this key to specify an image to be set on the cell's `mainPlaceholderImage` while the `mainImageView` is being loaded from a URL.
 */
extern NSString * const ALImageCellMainPlaceholderImageKey;     // mainPlaceholderImage

/**
 *  Use this key to specify whether or not the input is required.
 */
extern NSString * const ALInputRequiredKey;   // requiredHidden

///--------------------------------------------------------------
/// @name Secondary Image Keys
///--------------------------------------------------------------

/**
 *  Use this key to specify an image to be set on the cell's `secondaryImageView`.
 */
extern NSString * const ALImageCellSecondaryImageKey;                // secondaryImage

/**
 *  Use this key to specify an image name of an image within the main bundle to be set on the cell's `secondaryImageView`.
 */
extern NSString * const ALImageCellSecondaryImageNameKey;            // secondaryImageName

/**
 *  Use this key to specify a URL string to be used to load the image to be set on the cell's `secondaryImageView`.
 */
extern NSString * const ALImageCellSecondaryImageURLStringKey;       // secondaryImageURLString

/**
 *  Use this key to specify a `NSURL` to be used to load the image to be set on the cell's `secondaryImageView`.
 */
extern NSString * const ALImageCellSecondaryImageURLKey;             // secondaryImageURL

/**
 *  Use this key to specify an image to be set on the cell's `secondaryPlaceholderImage` while the `secondaryImageView` is being loaded from a URL.
 */
extern NSString * const ALImageCellSecondaryPlaceholderImageKey;     // secondaryPlaceholderImage

NS_ASSUME_NONNULL_END
