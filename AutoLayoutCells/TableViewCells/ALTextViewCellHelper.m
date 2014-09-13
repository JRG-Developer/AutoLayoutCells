//
//  ALTextViewCellHelper.m
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

#import "ALTextViewCellHelper.h"

#import <QuartzCore/QuartzCore.h>

#import "ALCellConstants.h"
#import "ALTextCellConstants.h"
#import "ALTextCellDelegate.h"

@implementation ALTextViewCellHelper

#pragma mark - Object Lifecycle

- (instancetype)initWithCell:(UITableViewCell *)cell
{
  self = [super init];
  if (self) {
    _cell = cell;
  }
  return self;
}

#pragma mark - Instance Methods

- (void)configureTextView:(UITextView *)textView
{
  CGColorRef colorRef = [[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor];
  [textView.layer setBorderColor:colorRef];
  [textView.layer setBorderWidth:2.0f];
}

#pragma mark - Values Dictionary

- (void)textView:(ALPlaceholderTextView *)textView setValuesFromDictionary:(NSDictionary *)valuesDictionary
{
  [self textView:textView setPlaceholderFromDictionary:valuesDictionary];
  [self textView:textView setTextFromDictionary:valuesDictionary];
  [self textView:textView setTypeFromDictionary:valuesDictionary];
}

#pragma mark - Placeholder

- (void)textView:(ALPlaceholderTextView *)textView setPlaceholderFromDictionary:(NSDictionary *)dictionary
{
  if (![textView respondsToSelector:@selector(setPlaceholder:)]) {
    return;
  }
  
  [self textView:textView setPlaceholderTextString:dictionary[ALTextCellPlaceholderTextKey]];
}

- (void)textView:(ALPlaceholderTextView *)textView setPlaceholderTextString:(NSString *)text
{
  [textView setPlaceholder:text];
}

#pragma mark - Text

- (void)textView:(UITextView *)textView setTextFromDictionary:(NSDictionary *)dictionary
{
  if (dictionary[ALCellAttributedValueKey]) {
    [self textView:textView setAttributedTextString:dictionary[ALCellAttributedValueKey]];
    
  } else {
    [self textView:textView setTextString:dictionary[ALCellValueKey]];
  }
}

- (void)textView:(UITextView *)textView setAttributedTextString:(NSAttributedString *)attributedText
{
  textView.attributedText = attributedText;
}

- (void)textView:(UITextView *)textView setTextString:(NSString *)text
{
  textView.text = text;
}

#pragma mark - Type

- (void)textView:(UITextView *)textView setTypeFromDictionary:(NSDictionary *)dictionary
{
  if (!dictionary[ALTextCellTypeKey]) {
    return;
  }
  
  ALTextCellType type = [dictionary[ALTextCellTypeKey] integerValue];
  
  switch (type)
  {
    case ALTextCellTypeDefault:
      [self setTextViewTypeDefault:textView];
      break;
      
    case ALTextCellTypeEmail:
      [self setTextViewTypeEmail:textView];
      break;
      
    case ALTextCellTypeName:
      [self setTextViewTypeName:textView];
      break;
      
    case ALTextCellTypeNoChecking:
      [self setTextViewTypeNoChecking:textView];
      break;
      
    case ALTextCellTypePassword:
      [self setTextViewTypePassword:textView];
      break;
      
    case ALTextCellTypeSentences:
      [self setTextViewTypeSentences:textView];
      break;
      
    case ALTextCellTypeNumber:
      [self setTextViewTypeNumber:textView];
      break;
      
    default:
      break;
  }
}

- (void)setTextViewTypeEmail:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textView.autocorrectionType = UITextAutocorrectionTypeNo;
  textView.keyboardType = UIKeyboardTypeEmailAddress;
  textView.secureTextEntry = NO;
  textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeName:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeWords;
  textView.autocorrectionType = UITextAutocorrectionTypeNo;
  textView.keyboardType = UIKeyboardTypeDefault;
  textView.secureTextEntry = NO;
  textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeNoChecking:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textView.autocorrectionType = UITextAutocorrectionTypeNo;
  textView.keyboardType = UIKeyboardTypeDefault;
  textView.secureTextEntry = NO;
  textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypePassword:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeNone;;
  textView.autocorrectionType = UITextAutocorrectionTypeNo;
  textView.keyboardType = UIKeyboardTypeDefault;
  textView.secureTextEntry = YES;
  textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeSentences:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  textView.autocorrectionType = UITextAutocorrectionTypeYes;
  textView.keyboardType = UIKeyboardTypeDefault;
  textView.secureTextEntry = NO;
  textView.spellCheckingType = UITextSpellCheckingTypeYes;
}

- (void)setTextViewTypeNumber:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textView.autocorrectionType = UITextAutocorrectionTypeNo;
  textView.keyboardType = UIKeyboardTypeNumberPad;
  textView.secureTextEntry = NO;
  textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeDefault:(UITextView *)textView
{
  textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  textView.autocorrectionType = UITextAutocorrectionTypeDefault;
  textView.keyboardType = UIKeyboardTypeDefault;
  textView.secureTextEntry = NO;
  textView.spellCheckingType = UITextSpellCheckingTypeDefault;
}

#pragma mark - ALSizingTextViewDelegate

- (void)textView:(ALAutoResizingTextView *)textView willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
  if ([self.delegate respondsToSelector:@selector(cell:textView:willChangeFromHeight:toHeight:)]) {
    [self.delegate cell:self.cell textView:textView willChangeFromHeight:oldHeight toHeight:newHeight];
  }
}

- (void)textView:(ALAutoResizingTextView *)textView didChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
  if ([self.delegate respondsToSelector:@selector(cell:textView:didChangeFromHeight:toHeight:)]) {
    [self.delegate cell:self textView:textView didChangeFromHeight:oldHeight toHeight:newHeight];
  }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
  if ([text rangeOfString:@"\n"].location != NSNotFound) {
    
    if ([self.delegate respondsToSelector:@selector(cell:willEndEditing:)]) {
      [self.delegate cell:self.cell willEndEditing:textView.text];
    }

    [textView resignFirstResponder];
    return NO;
  }
  
  return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cellWillBeginEditing:)]) {
    [self.delegate cellWillBeginEditing:self.cell];
  }
  
  return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cell:valueChanged:)]) {
    [self.delegate cell:self.cell valueChanged:textView.text];
  }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cell:didEndEditing:)]) {
    [self.delegate cell:self.cell didEndEditing:textView.text];
  }
}

@end
