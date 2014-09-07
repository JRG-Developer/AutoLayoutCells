//
//  UIImageView+ALActivityIndicatorView.h
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

#import <UIKit/UIKit.h>

/**
 *  The key used to associate the activity indicator view with the image view
 */
char const ALActivityIndicatorKey;

/**
 *  `UIImageView+ALActivityIndicatorView` adds convenience methods for adding/removing an associated activity indicator view with an image view.
 */
@interface UIImageView (ALActivityIndicatorView)

/**
 *  This method returns the associated activity indicator view.
 *
 *  @note This method does not setup/add an activity indicator view. Instead, use `AL_addActivityIndicatorViewWithStyle` to do such.
 *
 *  @return The associated activity indicator view.
 */
- (UIActivityIndicatorView *)AL_activityIndicatorView;;

/**
 *  If an associated activity indicator view already exists with the same style, this method simply returns it. Otherwise, it creates and associated a new activity indicator view with the given style.
 *
 *  @warning If the style is *not* valid, the existing activity indicator view will be removed and `nil` will be returned.
 *
 *  @param style The activity indicator view style to use to create the activity indicator view
 *
 *  @return The current activity indicator (if the styles match), a new activity indicator view with the given style (if valid), or `nil` if the style is not valid
 */
- (UIActivityIndicatorView *)AL_addActivityIndicatorViewWithStyle:(UIActivityIndicatorViewStyle)style;

/**
 *  This method removes and de-associates the activity indicator view from the image view.
 */
- (void)AL_removeActivityIndicatorView;

@end
