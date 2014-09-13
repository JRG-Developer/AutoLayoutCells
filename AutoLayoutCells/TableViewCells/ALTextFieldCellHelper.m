//
//  ALTextFieldHelper.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/11/14.
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

#import "ALTextFieldCellHelper.h"

#import "ALCellConstants.h"
#import "ALTextCellConstants.h"
#import "ALTextCellDelegate.h"

@implementation ALTextFieldCellHelper

#pragma mark - Object Lifecycle

- (instancetype)initWithCell:(UITableViewCell *)cell textField:(UITextField *)textField
{
  self = [super init];
  if (self) {

    _cell = cell;
    _textField = textField;
    
    [self configureTextField];
  }
  return self;
}

- (void)configureTextField
{
  self.textField.delegate = self;
  [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Instance Methods

#pragma mark - textField: setValuesFromDictionary

- (void)setValuesFromDictionary:(NSDictionary *)valuesDictionary
{
  [self setPlaceholderFromDictionary:valuesDictionary];
  [self setTextFromDictionary:valuesDictionary];
  [self setTypeFromDictionary:valuesDictionary];
}

#pragma mark - textField: setPlaceholderFromDictionary:

- (void)setPlaceholderFromDictionary:(NSDictionary *)dictionary
{
  if (![self.textField respondsToSelector:@selector(setPlaceholder:)]) {
    return;
  }
  
  [self setPlaceholderTextString:dictionary[ALTextCellPlaceholderTextKey]];
}

- (void)setPlaceholderTextString:(NSString *)text
{
  [self.textField setPlaceholder:text];
}

#pragma mark - textField: setTextFromDictionary:

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
  self.textField.attributedText = attributedText;
}

- (void)setTextString:(NSString *)text
{
  self.textField.text = text;
}

#pragma mark - textField: setTypeFromDictionary:

- (void)setTypeFromDictionary:(NSDictionary *)dictionary
{
  if (!dictionary[ALTextCellTypeKey]) {
    return;
  }
  
  ALTextCellType type = [dictionary[ALTextCellTypeKey] integerValue];
  
  switch (type)
  {
    case ALTextCellTypeDefault:
      [self setTextFieldTypeDefault];
      break;
      
    case ALTextCellTypeEmail:
      [self setTextFieldTypeEmail];
      break;
      
    case ALTextCellTypeName:
      [self setTextFieldTypeName];
      break;
      
    case ALTextCellTypeNoChecking:
      [self setTextFieldTypeNoChecking];
      break;
      
    case ALTextCellTypePassword:
      [self setTextFieldTypePassword];
      break;
      
    case ALTextCellTypeSentences:
      [self setTextFieldTypeSentences];
      break;
      
    case ALTextCellTypeNumber:
      [self setTextFieldTypeNumber];
      break;
  }
}

- (void)setTextFieldTypeDefault
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  self.textField.autocorrectionType = UITextAutocorrectionTypeDefault;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.secureTextEntry = NO;
  self.textField.spellCheckingType = UITextSpellCheckingTypeDefault;
}

- (void)setTextFieldTypeEmail
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textField.keyboardType = UIKeyboardTypeEmailAddress;
  self.textField.secureTextEntry = NO;
  self.textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeName
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.secureTextEntry = NO;
  self.textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeNoChecking
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.secureTextEntry = NO;
  self.textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypePassword
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;;
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.secureTextEntry = YES;
  self.textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

- (void)setTextFieldTypeSentences
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
  self.textField.autocorrectionType = UITextAutocorrectionTypeYes;
  self.textField.keyboardType = UIKeyboardTypeDefault;
  self.textField.secureTextEntry = NO;
  self.textField.spellCheckingType = UITextSpellCheckingTypeYes;
}

- (void)setTextFieldTypeNumber
{
  self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.textField.keyboardType = UIKeyboardTypeNumberPad;
  self.textField.secureTextEntry = NO;
  self.textField.spellCheckingType = UITextSpellCheckingTypeNo;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
  if ([text rangeOfString:@"\n"].location != NSNotFound) {
    
    if ([self.delegate respondsToSelector:@selector(cell:willEndEditing:)]) {
      [self.delegate cell:self.cell willEndEditing:textField.text];
    }
    
    [textField resignFirstResponder];
    return NO;
  }
  
  return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  if ([self.delegate respondsToSelector:@selector(cellWillBeginEditing:)]) {
    [self.delegate cellWillBeginEditing:self.cell];
  }
  
  return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
  if ([self.delegate respondsToSelector:@selector(cell:valueChanged:)]) {
    [self.delegate cell:self.cell valueChanged:textField.text];
  }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  if ([self.delegate respondsToSelector:@selector(cell:didEndEditing:)]) {
    [self.delegate cell:self.cell didEndEditing:textField.text];
  }
}

@end
