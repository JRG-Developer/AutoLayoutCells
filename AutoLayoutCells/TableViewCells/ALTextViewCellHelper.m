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
#import "ALCellDelegate.h"
#import "ALTextCellConstants.h"
#import "ALTextCellDelegate.h"

@implementation ALTextViewCellHelper

#pragma mark - Object Lifecycle

- (instancetype)initWithCell:(UITableViewCell *)cell textView:(ALAutoResizingTextView *)textView
{
  self = [super init];
  if (self) {
    _cell = cell;
    _textView = textView;
    
    [self configureTextView];
  }
  return self;
}

- (void)configureTextView
{
  [self.textView setDelegate:self];
}

#pragma mark - Values Dictionary

- (void)setValuesFromDictionary:(NSDictionary *)dictionary;
{
  [self setPlaceholderFromDictionary:dictionary];
  [self setTextFromDictionary:dictionary];
  [self setTypeFromDictionary:dictionary];
}

#pragma mark - Placeholder

- (void)setPlaceholderFromDictionary:(NSDictionary *)dictionary
{
  if (![self.textView respondsToSelector:@selector(setPlaceholder:)]) {
    return;
  }
  
  [self textView:self.textView setPlaceholderTextString:dictionary[ALTextCellPlaceholderTextKey]];
}

- (void)textView:(ALPlaceholderTextView *)textView setPlaceholderTextString:(NSString *)text
{
  [textView setPlaceholder:text];
}

#pragma mark - Text

- (void)setTextFromDictionary:(NSDictionary *)dictionary
{
  if (dictionary[ALCellAttributedValueKey]) {
    [self setAttributedTextString:dictionary[ALCellAttributedValueKey]];
    
  } else {
    [self setTextString:dictionary[ALCellValueKey]];
  }
}

- (void)setAttributedTextString:(NSAttributedString *)attributedText
{
  self.textView.attributedText = attributedText;
}

- (void)setTextString:(NSString *)text
{
  self.textView.text = text.length > 0 ? text : nil;
}

#pragma mark - Type

- (void)setTypeFromDictionary:(NSDictionary *)dictionary
{
  ALTextCellType type = [dictionary[ALTextCellTypeKey] integerValue] ?: ALTextCellTypeDefault;
  [self setTextCellType:type];
}

- (void)setTextCellType:(ALTextCellType)type {
  
  switch (type)
  {
      case ALTextCellTypeDefault:
      [self setTextViewTypeDefault];
      break;
      
      case ALTextCellTypeCustom:
      break;
      
      case ALTextCellTypeEmail:
      [self setTextViewTypeEmail];
      break;
      
      case ALTextCellTypeName:
      [self setTextViewTypeName];
      break;
      
      case ALTextCellTypeNoChecking:
      [self setTextViewTypeNoChecking];
      break;
      
      case ALTextCellTypeNumber:
      [self setTextViewTypeNumber];
      break;
      
      case ALTextCellTypeDecimalNumber:
      [self setTextViewTypeDecimalNumber];
      break;
      
      case ALTextCellTypePassword:
      [self setTextViewTypePassword];
      break;
      
      case ALTextCellTypeSentences:
      [self setTextViewTypeSentences];
      break;
  }
}

- (void)setTextViewTypeDefault
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  self.textView.autocorrectionType = UITextAutocorrectionTypeDefault;
  self.textView.keyboardType = UIKeyboardTypeDefault;
  self.textView.secureTextEntry = NO;
  self.textView.spellCheckingType = UITextSpellCheckingTypeDefault;
}

- (void)setTextViewTypeEmail
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textView.keyboardType = UIKeyboardTypeEmailAddress;
  self.textView.secureTextEntry = NO;
  self.textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeName
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeWords;
  self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textView.keyboardType = UIKeyboardTypeDefault;
  self.textView.secureTextEntry = NO;
  self.textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeNoChecking
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textView.keyboardType = UIKeyboardTypeDefault;
  self.textView.secureTextEntry = NO;
  self.textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeNumber
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textView.keyboardType = UIKeyboardTypeNumberPad;
  self.textView.secureTextEntry = NO;
  self.textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeDecimalNumber
{
    self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textView.keyboardType = UIKeyboardTypeDecimalPad;
    self.textView.secureTextEntry = NO;
    self.textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypePassword
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeNone;;
  self.textView.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textView.keyboardType = UIKeyboardTypeDefault;
  self.textView.secureTextEntry = YES;
  self.textView.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextViewTypeSentences
{
  self.textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  self.textView.autocorrectionType = UITextAutocorrectionTypeYes;
  self.textView.keyboardType = UIKeyboardTypeDefault;
  self.textView.secureTextEntry = NO;
  self.textView.spellCheckingType = UITextSpellCheckingTypeYes;
}

#pragma mark - ALAutoResizingTextViewDelegate

- (void)textView:(ALAutoResizingTextView *)textView willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
  if ([self.heightDelegate respondsToSelector:@selector(cellHeightWillChange:delta:)]) {
    
    CGFloat delta = newHeight - oldHeight;
    [self.heightDelegate cellHeightWillChange:self.cell delta:delta];
  }
}

- (void)textView:(ALAutoResizingTextView *)textView didChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
  if ([self.heightDelegate respondsToSelector:@selector(cellHeightDidChange:delta:)]) {
    
    CGFloat delta = newHeight - oldHeight;
    [self.heightDelegate cellHeightDidChange:self.cell delta:delta];
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
    
  } else if ([self.delegate respondsToSelector:@selector(cell:shouldChangeValueFromValue:toNewValue:)]) {
    
    NSString *oldValue = self.textView.text;
    NSString *newValue = [oldValue stringByReplacingCharactersInRange:range withString:text];
    return [self.delegate cell:self.cell shouldChangeValueFromValue:oldValue toNewValue:newValue];
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
  if (self.valueChangedBlock) {
    self.valueChangedBlock(textView.text);
  }
  
  if ([self.delegate respondsToSelector:@selector(cell:valueChanged:)]) {
    [self.delegate cell:self.cell valueChanged:textView.text];
  }
  
  if ([self.heightDelegate respondsToSelector:@selector(cell:valueChanged:)]) {
    [self.heightDelegate cell:self.cell valueChanged:textView.text];
  }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
  if ([self.delegate respondsToSelector:@selector(cell:didEndEditing:)]) {
    [self.delegate cell:self.cell didEndEditing:textView.text];
  }
}

@end
