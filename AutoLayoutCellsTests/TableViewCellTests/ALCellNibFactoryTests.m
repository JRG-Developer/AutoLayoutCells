//
//  ALCellNibFactoryTests.m
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

// Test Class
#import "ALTableViewCellNibFactory.h"

// Collaborators
#import "ALCell.h"
#import "ALBooleanCell.h"
#import "ALImageCell.h"
#import "ALLeftLabelCell.h"
#import "ALTextFieldCell.h"
#import "ALTextFieldOnlyCell.h"
#import "ALTextViewCell.h"
#import "ALTextViewOnlyCell.h"

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface ALCellNibFactoryTests : XCTestCase
@end

@implementation ALCellNibFactoryTests

#pragma mark - Utilities

- (id)verifySelector:(SEL)selector givesCellClass:(Class)cellClass
{
  UINib *nib = [ALTableViewCellNibFactory performSelector:selector];
  UIView *view = [[nib instantiateWithOwner:self options:nil] lastObject];
  
  expect(view).to.beInstanceOf(cellClass);
  return view;
}

#pragma mark - Cell With Name - Tests

- (void)test___cellWithName___ALCell___returnsInstanceOf___ALCell
{
  id cell = [ALTableViewCellNibFactory cellWithName:@"ALCell" owner:self];
  expect(cell).to.beInstanceOf([ALCell class]);
}

- (void)test___cellWithName___ALBooleanCell___returnsInstanceOf___ALBooleanCell
{
  id boolCell = [ALTableViewCellNibFactory cellWithName:@"ALBooleanCell" owner:self];
  expect(boolCell).to.beInstanceOf([ALBooleanCell class]);
}

#pragma mark - Cell Nib - Tests

- (void)test___booleanCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(booleanCellNib) givesCellClass:[ALBooleanCell class]];
}

- (void)test___cellNib___returnsCorrectNib
{
  [self verifySelector:@selector(cellNib) givesCellClass:[ALCell class]];
}

- (void)test___galleryCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(galleryCellNib) givesCellClass:[ALImageCell class]];
}

- (void)test___leftLabelCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(leftLabelCellNib) givesCellClass:[ALLeftLabelCell class]];
}

- (void)test___menuCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(menuCellNib) givesCellClass:[ALImageCell class]];
}

- (void)test___textFieldCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(textFieldCellNib) givesCellClass:[ALTextFieldCell class]];
}

- (void)test___textFieldOnlyCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(textFieldOnlyCellNib) givesCellClass:[ALTextFieldOnlyCell class]];
}

- (void)test___textViewCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(textViewCellNib) givesCellClass:[ALTextViewCell class]];
}

- (void)test___textViewOnlyCellNib___returnsCorrectNib
{
  [self verifySelector:@selector(textViewOnlyCellNib) givesCellClass:[ALTextViewOnlyCell class]];
}

@end