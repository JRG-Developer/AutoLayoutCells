//
//  UIView+ALRecursiveFirstResponder.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/4/16.
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

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ALFirstResponder)

/**
 *  Use this method to recurisvely resign the first responder.
 *
 *  @return `YES` if the first responder was found and resigned or `NO` otherwise
 */
- (BOOL)AL_recursivelyResignFirstResponder;

/**
 *  Use this method to recursively find the first responder view.
 *
 *  @return The first responder view or `nil` if not found.
 */
- (nullable UIView *)AL_recursivelyFindFirstResponder;

@end

NS_ASSUME_NONNULL_END
