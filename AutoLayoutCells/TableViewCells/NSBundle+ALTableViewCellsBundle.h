//
//  NSBundle+ALTableViewCellsBundle.h
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

@import Foundation;

extern NSString * const ALTableViewCellsBundleName;

/**
 *  `NSBundle+ALTableViewCellsBundle` provides a convenience method for getting the `ALTableViewCellsBundle`, which includes all of the nibs and assets used by the `TableViewCells` subspec.
 */
@interface NSBundle (ALTableViewCellsBundle)

/**
 *  This is a convenience method for getting the `ALTableViewCellsBundle`.
 *
 *  @return A reference to the `ALTableViewCellsBundle`
 */
+ (NSBundle *)ALTableViewCellsBundle;

@end

/**
 *  These methods should be considered "protected" and should *not* be used outside this class category, except for unit testing.
 *
 *  @discussion These methods are exposed for unit testing.
 */
@interface NSBundle (ALTableViewCellsBundle_Protected)

/**
 *  This method sets the `ALTableViewCellsBundle` using the given `path`.
 *
 *  @param path The path to use to set `ALTableViewCellsBundle`
 */

+ (void)_setALTableViewCellsBundleWithPath:(NSString *)path;

/**
 *  This method returns the path for the `ALTableViewCellsBundle` using the `resourcePath` of the main bundle and appending the `ALTableViewCellsBundleName`.
 *
 *  @return The path for `ALTableViewCellsBundle`
 */
+ (NSString *)_pathForALTableViewCellsBundle;

@end
