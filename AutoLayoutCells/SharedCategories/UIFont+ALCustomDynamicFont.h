//
//  UIFont+ALCustomDynamicFont.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/7/14.
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
 *  `UIFont+ALCustomDynamicFont` provides methods to get the point size for a given font text style or font given a font name and text style.
 */
@interface UIFont (ALCustomDynamicFont)

///--------------------------------------------------------------
/// @name Font Creation
///--------------------------------------------------------------

/**
 *  Use this method to create a font with the font name sized according to the text style.
 *
 *  @param fontName      The font name
 *  @param textStyle     The font text style
 *
 *  @return A font with the font name sized according to the text style
 */
+ (UIFont *)AL_fontWithName:(NSString *)fontName textStyle:(NSString *)textStyle;

/**
 *  Use this method for getting the font point size from a given text style.
 *
 *  @warning Font size actually depends on text style and the value of `[[UIApplication sharedApplication] preferredContentSizeCategory]`. Be warned that this value *will* change if the user changes the preferred content sizes via the settings app!
 *
 *  @param textStyle The font text style
 *
 *  @return The font point size from the text style.
 */
+ (CGFloat)AL_pointSizeFromTextStyle:(NSString *)textStyle;

///--------------------------------------------------------------
/// @name Font Size Table
///--------------------------------------------------------------

/**
 *  This method returns the font size table, which is a dictionary of text styles (keys) to content size dictionaries (objects).
 *
 *  @discussion The font size table is created using `dispatch_once`.
 *
 *  @return The font size table
 */
+ (NSDictionary *)AL_fontSizeTable;

/**
 *  Use this method to set (using an existing text style key) or add (using a new text style key) a text-style/content-size dictionary key-pair to the font size table.
 *
 *  @warning This method throws a runtime exception if either `textStyle` or `contentSizeDictionary` is `nil`.
 *
 *  @param textStyle              The font text style string
 *  @param contentSizeDictionary  The content size dictionary
 */
+ (void)AL_setTextStyle:(NSString *)textStyle contentSizeDictionary:(NSDictionary *)contentSizeDictionary;

@end
