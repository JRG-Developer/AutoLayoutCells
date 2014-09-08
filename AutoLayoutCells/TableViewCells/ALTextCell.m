//
//  ALTextCell.m
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

#import "ALTextCell.h"

#import <AutoLayoutTextViews/ALAutoResizingTextView.h>

#import "ALTextCellDelegate.h"
#import "ALTextViewHelper.h"
#import "UIView+ALRefreshFont.h"

@implementation ALTextCell

#pragma mark - Object Lifecycle

- (void)commonInit
{
  [super commonInit];
  _textViewHelper = [[ALTextViewHelper alloc] init];
  _textViewHelper.delegate = self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self configureSelf];
  [self configureTextView];
}

- (void)configureSelf
{
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)configureTextView
{
  self.textView.delegate = self.textViewHelper;
  [ALTextViewHelper configureTextView:self.textView];
}

#pragma mark - Dynamic Type Text

- (void)refreshFonts
{
  [super refreshFonts];
  [self.textView AL_refreshPreferredFont];
}

#pragma mark - Set Values Dictionary

- (void)setValuesDictionary:(NSDictionary *)valuesDictionary
{
  [super setValuesDictionary:valuesDictionary];
  [ALTextViewHelper textView:self.textView setTextFromDictionary:valuesDictionary];
  [ALTextViewHelper textView:self.textView setTypeFromDictionary:valuesDictionary];
}

#pragma mark - ALTextViewHelperDelegate - Text Editing

- (void)textViewHelper:(ALTextViewHelper *)helper textViewWillBeginEditing:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cellWillBeginEditing:)]) {
    [self.delegate cellWillBeginEditing:self];
  }
}

- (void)textViewHelper:(ALTextViewHelper *)helper textViewDidChange:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cell:valueChanged:)]) {
    [self.delegate cell:self valueChanged:textView.text];
  }
}

- (void)textViewHelper:(ALTextViewHelper *)helper textViewDidEndEditing:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cell:didEndEditing:)]) {
    [self.delegate cell:self didEndEditing:textView.text];
  }
}

- (void)textViewHelper:(ALTextViewHelper *)helper textView:(ALAutoResizingTextView *)textView
  willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
  SEL selector = @selector(cell:textView:willChangeFromHeight:toHeight:);
  
  if ([self.delegate respondsToSelector:selector]) {
    [self.delegate cell:self textView:self.textView willChangeFromHeight:oldHeight toHeight:newHeight];
  }
}

- (void)textViewHelper:(ALTextViewHelper *)helper textView:(ALAutoResizingTextView *)textView
   didChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
  SEL selector = @selector(cell:textView:didChangeFromHeight:toHeight:);
  
  if ([self.delegate respondsToSelector:selector]) {
    [self.delegate cell:self textView:self.textView didChangeFromHeight:oldHeight toHeight:newHeight];
  }
}

@end
