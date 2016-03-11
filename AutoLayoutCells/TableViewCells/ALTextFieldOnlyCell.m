//
//  ALTextFieldOnlyCell.m
//  AutoLayoutCells
//
//  Created by Joshua Greene on 9/14/14.
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

#import "ALTextFieldOnlyCell.h"

#import "ALTextFieldCellHelper.h"

@interface ALTextFieldOnlyCell()
@property (strong, nonatomic, readwrite) ALTextFieldCellHelper *textFieldHelper;
@end

@implementation ALTextFieldOnlyCell
@dynamic delegate;

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

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setupTextFieldHelper];
}

- (void)setupTextFieldHelper
{
  self.textFieldHelper = [[ALTextFieldCellHelper alloc] initWithCell:self textField:self.textField];
  self.textFieldHelper.delegate = self.delegate;
}

#pragma mark - Dynamic Type Text

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
  [super contentSizeCategoryDidChange:notification];
  [self refreshFonts];
}

- (void)refreshFonts
{
  self.textField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

#pragma mark - Custom Accessors

- (void)setDelegate:(id<ALCellDelegate>)delegate
{
  [super setDelegate:delegate];
  self.textFieldHelper.delegate = delegate;
}

- (void)setValueChangedBlock:(void (^)(id))valueChangedBlock
{
  [super setValueChangedBlock:valueChangedBlock];
  self.textFieldHelper.valueChangedBlock = valueChangedBlock;
}

#pragma mark - Set Values From Dictionary

- (void)setValuesFromDictionary:(NSDictionary *)dictionary
{
  [super setValuesFromDictionary:dictionary];
  [self.textFieldHelper setValuesFromDictionary:dictionary];
}

@end
