//
//  ALCell.m
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

#import "ALCell.h"

#import "ALCellConstants.h"

@implementation ALCell

#pragma mark - Dynamic Type Text

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
  [super contentSizeCategoryDidChange:notification];
  [self refreshFonts];
}

- (void)refreshFonts
{
  self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
  self.subtitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

#pragma mark - Set Values From Dictionary

- (void)setValuesFromDictionary:(NSDictionary *)dictionary
{
  [super setValuesFromDictionary:dictionary];
  [self setTitleFromDictionary:dictionary];
  [self setSubtitleFromDictionary:dictionary];
}

- (void)setTitleFromDictionary:(NSDictionary *)dictionary
{
  if (dictionary[ALCellAttributedTitleKey]) {
    [self setAttributedTitleString:dictionary[ALCellAttributedTitleKey]];
  } else {
    [self setTitleString:dictionary[ALCellTitleKey]];
  }
}

- (void)setAttributedTitleString:(NSAttributedString *)title
{
  self.titleLabel.attributedText = title.length ? title : nil;
}

- (void)setTitleString:(NSString *)title
{
  self.titleLabel.text = title.length ? title : nil;
}

- (void)setSubtitleFromDictionary:(NSDictionary *)dictionary
{
  if (dictionary[ALCellAttributedSubtitleKey]) {
    [self setAttributedSubtitleString:dictionary[ALCellAttributedSubtitleKey]];
  } else {
    [self setSubtitleString:dictionary[ALCellSubtitleKey]];
  }
}

- (void)setAttributedSubtitleString:(NSAttributedString *)subtitle
{
  self.subtitleLabel.attributedText = subtitle.length ? subtitle : nil;
}

- (void)setSubtitleString:(NSString *)subtitle
{
  self.subtitleLabel.text = subtitle.length ? subtitle : nil;
}

@end
