//
//  ALTextViewHelperDelegate.h
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

@class ALTextViewHelper;
@class ALAutoResizingTextView;

/**
 *  `ALTextViewHelperDelegate` defines optional methods to inform its delegate (which should be a *cell*, not a controller) of value-related and height-related events.
 *  @discussion It's expected that the cell will forward these events onto its own delegate.
 */
@protocol ALTextViewHelperDelegate <NSObject>
@optional

/**
 *  This method is called when the text view will begin editing.
 *
 *  @param helper   The text view helper that manages the text view
 *  @param textView The text view that will begin editing
 */
- (void)textViewHelper:(ALTextViewHelper *)helper textViewWillBeginEditing:(UITextView *)textView;

/**
 *  This method is called when the text view's value did change.
 *
 *  @param helper   The text view helper that manages the text view
 *  @param textView The text view whose value did change
 */
- (void)textViewHelper:(ALTextViewHelper *)helper textViewDidChange:(UITextView *)textView;

/**
 *  This method is called when the text view will end editing.
 *
 *  @param helper   The text view helper that manages the text view
 *  @param textView The text view that did end editing
 */
- (void)textViewHelper:(ALTextViewHelper *)helper textViewDidEndEditing:(UITextView *)textView;

/**
 *  This method is called when the text view will change its height
 *
 *  @param helper    The text view helper that manages the text view
 *  @param textView  The text view whose height will change
 *  @param oldHeight The old height value
 *  @param newHeight The new height value
 */
- (void)textViewHelper:(ALTextViewHelper *)helper textView:(ALAutoResizingTextView *)textView
  willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight;

/**
 *  This method is called when the text view did change its height
 *
 *  @param helper    The text view helper that manages the text view
 *  @param textView  The text view whose height did change
 *  @param oldHeight The old height value
 *  @param newHeight The new height value
 */
- (void)textViewHelper:(ALTextViewHelper *)helper textView:(ALAutoResizingTextView *)textView
   didChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight;

@end
