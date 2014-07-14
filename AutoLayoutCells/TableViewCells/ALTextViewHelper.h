//
//  ALTextViewHelper.h
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

#import <AutoLayoutTextViews/ALAutoResizingTextView.h>
#import "ALTextViewHelperDelegate.h"

/**
 *  `ALTextViewHelper` encapsulates common text-view-related tasks, including type configuration and responding to value-related events.
 */
@interface ALTextViewHelper : NSObject <ALAutoResizingTextViewDelegate>

/**
 *  The delegate to inform of height change and value-related events
 *  @see `ALTextViewHelperDelegate` for more details
 */
@property (nonatomic, weak) id<ALTextViewHelperDelegate>delegate;

/**
 *  This method configures the appearance of the `textView`.
 *
 *  @param textView The text view to be configured
 */
+ (void)configureTextView:(UITextView *)textView;

/**
 *  This method sets the `textView` placeholder from the dictionary.
 *  @see `ALTextCellConstants` placeholder keys
 *
 *  @param textView   The text view whose placeholder will be set
 *  @param dictionary The dictionary containing the placeholder value
 */
+ (void)textView:(ALAutoResizingTextView *)textView setPlaceholderFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method sets the `textView` text from the dictionary.
 *  @see `ALCellConstants.h` value keys
 *
 *  @param textView   The text view whose text will be set
 *  @param dictionary The dictionary containing the text value
 */
+ (void)textView:(UITextView *)textView setTextFromDictionary:(NSDictionary *)dictionary;

/**
 *  This method configures the `textView` based on the type (`ALTextViewType`) from the dictionary.
 *  @see `ALTextCellConstants` for `ALTextViewType` enum
 *
 *  @param textView   The text view to be configured
 *  @param dictionary The dictionary containing the type value
 */
+ (void)textView:(UITextView *)textView setTypeFromDictionary:(NSDictionary *)dictionary;
@end

@interface ALTextViewHelper (Protected)

/**
 *  This method is called within `textView:setPlaceholderFromDictionary:` to set the `textView` placeholder (if present within the dictionary)
 *
 *  @param textView The text view whose placeholder will be set
 *  @param text     The text value of the placeholder to be set
 */
+ (void)textView:(UITextView *)textView setPlaceholderTextString:(NSString *)text;

/**
 *  This method is called within `textView:setTextFromDictionary` to set the `textView` attributed text (if present within the dictionary)
 *
 *  @param textView       The text view whose attributed text will be set
 *  @param attributedText The attributed text to be set
 */
+ (void)textView:(UITextView *)textView setAttributedTextString:(NSAttributedString *)attributedText;

/**
 *  This method is called within `textView:setTextFromDictionary` to set the `textView` text (if present within the dictionary without an attributed text value)
 *
 *  @param textView       The text view whose attributed text will be set
 *  @param attributedText The attributed text to be set
 */
+ (void)textView:(UITextView *)textView setTextString:(NSString *)text;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypeEmail`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypeEmail:(UITextView *)textView;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypeName`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypeName:(UITextView *)textView;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypeNoChecking`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypeNoChecking:(UITextView *)textView;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypePassword`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypePassword:(UITextView *)textView;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypeSentences`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypeSentences:(UITextView *)textView;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypeNumber`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypeNumber:(UITextView *)textView;

/**
 *  This method is called within `textView:setTypeFromDictionary:` to configure the text view as `ALTextViewTypeDefault`
 *
 *  @param textView The text view
 */
+ (void)setTextViewTypeDefault:(UITextView *)textView;
@end
