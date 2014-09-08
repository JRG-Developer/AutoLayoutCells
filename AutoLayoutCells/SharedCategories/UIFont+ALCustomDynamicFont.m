//
//  UIFont+ALCustomDynamicFont.m
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

//  Point sizes cudos Bob Spryn from this StackOverflow post:
//  http://stackoverflow.com/questions/20510094/how-to-use-a-custom-font-with-dynamic-text-sizes-in-ios7

#import "UIFont+ALCustomDynamicFont.h"

static NSMutableDictionary *_ALFontSizeTable = nil;

@implementation UIFont (ALCustomDynamicFont)

#pragma mark - Font Creation

+ (UIFont *)AL_fontWithName:(NSString *)name textStyle:(NSString *)textStyle
{
  CGFloat pointSize = [self AL_pointSizeFromTextStyle:textStyle];
  return pointSize > 0 ? [UIFont fontWithName:name size:pointSize] : nil;
}

+ (CGFloat)AL_pointSizeFromTextStyle:(NSString *)textStyle
{
  NSString *contentSizeCategory = [[UIApplication sharedApplication] preferredContentSizeCategory];
  return [[self AL_fontSizeTable][textStyle][contentSizeCategory] floatValue];
}

#pragma mark - Font Size Table

+ (NSDictionary *)AL_fontSizeTable
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    _ALFontSizeTable = [@{UIFontTextStyleHeadline:    [self AL_headlineContentSizeDictionary],
                         UIFontTextStyleSubheadline:  [self AL_subheadlineContentSizeDictionary],
                         UIFontTextStyleBody:         [self AL_bodyContentSizeDictionary],
                         UIFontTextStyleCaption1:     [self AL_caption1ContentSizeDictionary],
                         UIFontTextStyleCaption2:     [self AL_caption2ContentSizeDictionary],
                         UIFontTextStyleFootnote:     [self AL_footnoteContentSizeDictionary]}
                        mutableCopy];
  });
  return _ALFontSizeTable;
}

+ (void)AL_setTextStyle:(NSString *)textStyle contentSizeDictionary:(NSDictionary *)contentSizeDictionary
{
  NSParameterAssert(textStyle);
  NSParameterAssert(contentSizeDictionary);
  
  _ALFontSizeTable[textStyle] = contentSizeDictionary;
}

+ (NSDictionary *)AL_headlineContentSizeDictionary
{
  return @{UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:  @26,
           UIContentSizeCategoryAccessibilityExtraExtraLarge:       @25,
           UIContentSizeCategoryAccessibilityExtraLarge:            @24,
           UIContentSizeCategoryAccessibilityLarge:                 @24,
           UIContentSizeCategoryAccessibilityMedium:                @23,
           UIContentSizeCategoryExtraExtraExtraLarge:               @23,
           UIContentSizeCategoryExtraExtraLarge:                    @22,
           UIContentSizeCategoryExtraLarge:                         @21,
           UIContentSizeCategoryLarge:                              @20,
           UIContentSizeCategoryMedium:                             @19,
           UIContentSizeCategorySmall:                              @18,
           UIContentSizeCategoryExtraSmall:                         @17};
}

+ (NSDictionary *)AL_subheadlineContentSizeDictionary
{
  return @{UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:  @24,
           UIContentSizeCategoryAccessibilityExtraExtraLarge:       @23,
           UIContentSizeCategoryAccessibilityExtraLarge:            @22,
           UIContentSizeCategoryAccessibilityLarge:                 @22,
           UIContentSizeCategoryAccessibilityMedium:                @21,
           UIContentSizeCategoryExtraExtraExtraLarge:               @21,
           UIContentSizeCategoryExtraExtraLarge:                    @20,
           UIContentSizeCategoryExtraLarge:                         @19,
           UIContentSizeCategoryLarge:                              @18,
           UIContentSizeCategoryMedium:                             @17,
           UIContentSizeCategorySmall:                              @16,
           UIContentSizeCategoryExtraSmall:                         @15};
}

+ (NSDictionary *)AL_bodyContentSizeDictionary
{
  return @{UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:  @21,
           UIContentSizeCategoryAccessibilityExtraExtraLarge:       @20,
           UIContentSizeCategoryAccessibilityExtraLarge:            @19,
           UIContentSizeCategoryAccessibilityLarge:                 @19,
           UIContentSizeCategoryAccessibilityMedium:                @18,
           UIContentSizeCategoryExtraExtraExtraLarge:               @18,
           UIContentSizeCategoryExtraExtraLarge:                    @17,
           UIContentSizeCategoryExtraLarge:                         @16,
           UIContentSizeCategoryLarge:                              @15,
           UIContentSizeCategoryMedium:                             @14,
           UIContentSizeCategorySmall:                              @13,
           UIContentSizeCategoryExtraSmall:                         @12};
}

+ (NSDictionary *)AL_caption1ContentSizeDictionary
{
  return @{UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:  @19,
           UIContentSizeCategoryAccessibilityExtraExtraLarge:       @18,
           UIContentSizeCategoryAccessibilityExtraLarge:            @17,
           UIContentSizeCategoryAccessibilityLarge:                 @17,
           UIContentSizeCategoryAccessibilityMedium:                @16,
           UIContentSizeCategoryExtraExtraExtraLarge:               @16,
           UIContentSizeCategoryExtraExtraLarge:                    @16,
           UIContentSizeCategoryExtraLarge:                         @15,
           UIContentSizeCategoryLarge:                              @14,
           UIContentSizeCategoryMedium:                             @13,
           UIContentSizeCategorySmall:                              @12,
           UIContentSizeCategoryExtraSmall:                         @12};
}

+ (NSDictionary *)AL_caption2ContentSizeDictionary
{
  return @{UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:  @18,
           UIContentSizeCategoryAccessibilityExtraExtraLarge:       @17,
           UIContentSizeCategoryAccessibilityExtraLarge:            @16,
           UIContentSizeCategoryAccessibilityLarge:                 @16,
           UIContentSizeCategoryAccessibilityMedium:                @15,
           UIContentSizeCategoryExtraExtraExtraLarge:               @15,
           UIContentSizeCategoryExtraExtraLarge:                    @14,
           UIContentSizeCategoryExtraLarge:                         @14,
           UIContentSizeCategoryLarge:                              @13,
           UIContentSizeCategoryMedium:                             @12,
           UIContentSizeCategorySmall:                              @12,
           UIContentSizeCategoryExtraSmall:                         @11};
}

+ (NSDictionary *)AL_footnoteContentSizeDictionary
{
  return @{UIContentSizeCategoryAccessibilityExtraExtraExtraLarge:  @16,
           UIContentSizeCategoryAccessibilityExtraExtraLarge:       @15,
           UIContentSizeCategoryAccessibilityExtraLarge:            @14,
           UIContentSizeCategoryAccessibilityLarge:                 @14,
           UIContentSizeCategoryAccessibilityMedium:                @13,
           UIContentSizeCategoryExtraExtraExtraLarge:               @13,
           UIContentSizeCategoryExtraExtraLarge:                    @12,
           UIContentSizeCategoryExtraLarge:                         @12,
           UIContentSizeCategoryLarge:                              @11,
           UIContentSizeCategoryMedium:                             @11,
           UIContentSizeCategorySmall:                              @10,
           UIContentSizeCategoryExtraSmall:                         @10};
}

@end
