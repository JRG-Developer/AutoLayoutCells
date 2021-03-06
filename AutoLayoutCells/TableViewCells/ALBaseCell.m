//
//  ALBaseCell.m
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

#import "ALBaseCell.h"

static BOOL _ALShouldRegisterForFontChanges = YES;

@implementation ALBaseCell

#pragma mark - Class Configuration

+ (void)setShouldRegisterForFontChanges:(BOOL)shouldRegister
{
  _ALShouldRegisterForFontChanges = shouldRegister;
}

+ (BOOL)shouldRegisterForFontChanges
{
  return _ALShouldRegisterForFontChanges;
}

#pragma mark - Object Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit
{  
  if ([[self class] shouldRegisterForFontChanges]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  }
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Set Values From Dictionary

- (void)setValuesFromDictionary:(NSDictionary *)dictionary __attribute((objc_requires_super))
{
  // Intentionally left empty
}

#pragma mark - Dynamic Type Text

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
  // Intentionally left empty
}

@end
