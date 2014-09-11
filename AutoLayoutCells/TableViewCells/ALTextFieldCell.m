//
//  ALTextFieldCell.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/10/14.
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

#import "ALTextFieldCell.h"

#import "ALTextCellConstants.h"
#import "ALCellDelegate.h"
#import "UIView+ALRefreshFont.h"

@implementation ALTextFieldCell

#pragma mark - Object Lifecycle

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self configureTextField];
}

- (void)configureTextField
{
  [self.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventValueChanged];
  self.textField.delegate = self;
}

#pragma mark - Dynamic Type Text

- (void)refreshFonts
{
  [super refreshFonts];
  [self.textField AL_refreshPreferredFont];
}

#pragma mark - Set Values Dictionary

- (void)setValuesDictionary:(NSDictionary *)valuesDictionary
{
  [super setValuesDictionary:valuesDictionary];
  [self setTextFromDictionary:valuesDictionary];
  [self setTextPlaceholderFromDictionary:valuesDictionary];
  [self setTextInputStyleFromDictionary:valuesDictionary];
}

- (void)setTextFromDictionary:(NSDictionary *)dictionary
{
  if (dictionary[ALCellAttributedValueKey]) {
    [self setTextFieldAttributedValueText:dictionary[ALCellAttributedValueKey]];
    
  } else {
    [self setTextFieldValueText:dictionary[ALCellValueKey]];

  }
}

- (void)setTextFieldAttributedValueText:(NSAttributedString *)text
{
  self.textField.attributedText = text.length > 0 ? text : nil;
}

- (void)setTextFieldValueText:(NSString *)text
{
  self.textField.text = text.length > 0 ? text : nil;
}

- (void)setTextPlaceholderFromDictionary:(NSDictionary *)dictionary
{
  self.textField.placeholder = dictionary[ALTextCellPlaceholderTextKey];
}

- (void)setTextInputStyleFromDictionary:(NSDictionary *)dictionary
{
  ALTextCellType type = [dictionary[ALTextCellTypeKey] integerValue];
  
  switch (type)
  {
    case ALTextCellTypeEmail:
      [self setTextFieldTypeEmail:self.textField];
      break;
      
    case ALTextCellTypeName:
      [self setTextFieldTypeName:self.textField];
      break;
      
    case ALTextCellTypeNoChecking:
      [self setTextFieldTypeNoChecking:self.textField];
      break;
      
    case ALTextCellTypePassword:
      [self setTextFieldTypePassword:self.textField];
      break;
      
    case ALTextCellTypeSentences:
      [self setTextFieldTypeSentences:self.textField];
      break;
      
    case ALTextCellTypeNumber:
      [self setTextFieldTypeNumber:self.textField];
      break;
      
    case ALTextCellTypeDefault:
    default:
      [self setTextFieldTypeDefault:self.textField];
      break;
  }
}

- (void)setTextFieldTypeEmail:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.keyboardType = UIKeyboardTypeEmailAddress;
  textField.secureTextEntry = NO;
  textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeName:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.secureTextEntry = NO;
  textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeNoChecking:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.secureTextEntry = NO;
  textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypePassword:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.secureTextEntry = YES;
  textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeSentences:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  textField.autocorrectionType = UITextAutocorrectionTypeYes;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.secureTextEntry = NO;
  textField.spellCheckingType = UITextSpellCheckingTypeYes;
}

- (void)setTextFieldTypeNumber:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.keyboardType = UIKeyboardTypeNumberPad;
  textField.secureTextEntry = NO;
  textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeDefault:(UITextField *)textField
{
  textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  textField.autocorrectionType = UITextAutocorrectionTypeDefault;
  textField.keyboardType = UIKeyboardTypeDefault;
  textField.secureTextEntry = NO;
  textField.spellCheckingType = UITextSpellCheckingTypeDefault;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  if ([self.delegate respondsToSelector:@selector(cellWillBeginEditing:)]) {
    [self.delegate cellWillBeginEditing:self];
  }
  
  return YES;
}

- (void)textFieldValueChanged:(UITextField *)textField
{
  if ([self.delegate respondsToSelector:@selector(cell:valueChanged:)]) {
    [self.delegate cell:self valueChanged:self.textField.text];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  
  if ([self.delegate respondsToSelector:@selector(cell:willEndEditing:)]) {
    [self.delegate cell:self willEndEditing:self.textField.text];
  }
  
  return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  if ([self.delegate respondsToSelector:@selector(cell:didEndEditing:)]) {
    [self.delegate cell:self didEndEditing:self.textField.text];
  }
}
  

@end
