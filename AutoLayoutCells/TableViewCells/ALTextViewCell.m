//
//  ALTextViewCell.m
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

#import "ALTextViewCell.h"

#import "ALTextViewCellHelper.h"

@interface ALTextViewCell ()
@property (strong, nonatomic, readwrite) ALTextViewCellHelper *textViewHelper;
@end

@implementation ALTextViewCell

#pragma mark - Object Lifecycle

- (void)commonInit
{
  [super commonInit];
  [self configureSelf];
}

- (void)configureSelf
{
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark - Dynamic Type Text

- (void)refreshFonts
{
  [super refreshFonts];
  self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

#pragma mark - Custom Accessors

- (void)setDelegate:(id<ALTextCellDelegate>)delegate
{
  self.textViewHelper.delegate = delegate;
}

- (id<ALTextCellDelegate>)delegate
{
  return [self.textViewHelper delegate];
}

- (void)setTextView:(ALAutoResizingTextView *)textView
{
  if (_textView == textView) {
    return;
  }
  
  _textView = textView;
  self.textViewHelper = [[ALTextViewCellHelper alloc] initWithCell:self textView:self.textView];
}

#pragma mark - Set Values Dictionary

- (void)setValuesFromDictionary:(NSDictionary *)dictionary
{
  [super setValuesFromDictionary:dictionary];
  [self.textViewHelper setValuesFromDictionary:dictionary];
}

@end
