//
//  ALImageCellTests.m
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
#import "ALImageCell.h"
#import "ALImageCellConstants.h"

// Collaborators
#import "NSBundle+ALTableViewCellsBundle.h"
#import "Test_ALTableViewCellNibFactory.h"

// Test Support
#import <XCTest/XCTestCase.h>
#import <objc/runtime.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

static UIImage *image;

@interface UIImage (Test_Methods)

+ (UIImage *)test_imageNamed:(NSString *)name;

@end

@implementation UIImage (Test_Methods)

+ (UIImage *)test_imageNamed:(NSString *)name
{
  return image;
}

@end

@interface ALImageCellTests : XCTestCase
@end

@implementation ALImageCellTests
{
  ALImageCell *sut;
  
  id constraint;
  id imageView;
}

#pragma mark - Test Lifecycle

- (void)setUp
{
  [super setUp];
  sut = [[ALImageCell alloc] init];
}

#pragma mark - Given

- (void)givenTestImage
{
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *path = [bundle pathForResource:@"test_image" ofType:@"png"];
  image = [[UIImage alloc] initWithContentsOfFile:path];
}

- (void)givenMockConstraintWithConstant:(CGFloat)constant
{
  constraint = OCMClassMock([NSLayoutConstraint class]);
  OCMStub([constraint constant]).andReturn(constant);
}

- (void)givenMockConstraintWithExpecations:(CGFloat)constant
{
  constraint = OCMClassMock([NSLayoutConstraint class]);
  OCMStub([constraint constant]).andReturn(constant);
  
  [[constraint reject] setConstant:0];
  [[constraint expect] setConstant:constant];
}

- (void)givenMockMainImageView
{
  imageView = OCMClassMock([UIImageView class]);
  sut.mainImageView = imageView;
}

- (void)givenMockSecondaryImageView
{
  imageView = OCMClassMock([UIImageView class]);
  sut.secondaryImageView = imageView;
}

#pragma mark - Runtime Swaps

- (void)swap___imageNamed___methods
{
  Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
  Method m2 = class_getClassMethod([UIImage class], @selector(test_imageNamed:));
  method_exchangeImplementations(m1, m2);
}

#pragma mark - Placeholder Image - Tests

- (void)test___setValuesDictionary___sets_mainPlaceholderImage
{
  // given
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellMainPlaceholderImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.mainImagePlaceholder).to.equal(image);
}

- (void)test___setValuesDictionary___sets_secondaryPlaceholderImage
{
  // given
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellSecondaryPlaceholderImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  expect(sut.secondaryImagePlaceholder).to.equal(image);
}

#pragma mark - Set Constraint Constant - Tests

#pragma mark - mainImageView Constraints - Tests

- (void)test___setValuesDictionary___noImage_sets_mainImageViewLeadingConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:8.0f];
  sut.mainImageViewLeadingConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  [[constraint verify] setConstant:0];
}

- (void)test___setValuesDictionary___hasImage_sets_mainImageViewLeadingConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:8.0f];
  sut.mainImageViewLeadingConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellMainImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

- (void)test___setValuesDictionary___noImage_sets_mainImageViewTrailingConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:8.0f];
  sut.mainImageViewTrailingConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  OCMVerify([constraint setConstant:0]);
}

- (void)test___setValuesDictionary___hasImage_sets_mainImageViewTrailingConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:8.0f];
  sut.mainImageViewTrailingConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellMainImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

- (void)test___setValuesDictionary___noImage_sets_mainImageViewWidthConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:50.0f];
  sut.mainImageViewWidthConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  OCMVerify([constraint setConstant:0]);
}

- (void)test___setValuesDictionary___hasImage_sets_mainImageViewWidthConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:50.0f];
  sut.mainImageViewWidthConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellMainImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

- (void)test___setValuesDictionary___noImage_sets_mainImageViewHeightConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:50.0f];
  sut.mainImageViewHeightConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  OCMVerify([constraint setConstant:0]);
}

- (void)test___setValuesDictionary___hasImage_sets_mainImageViewHeightConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:50.0f];
  sut.mainImageViewHeightConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellMainImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

#pragma mark - secondaryImageView Constraints - Tests

- (void)test___setValuesDictionary___noImage_sets_secondaryImageViewLeadingConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:8.0f];
  sut.secondaryImageViewLeadingConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  OCMVerify([constraint setConstant:0]);
}

- (void)test___setValuesDictionary___hasImage_sets_secondaryImageViewLeadingConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:8.0f];
  sut.secondaryImageViewLeadingConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellSecondaryImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

- (void)test___setValuesDictionary___noImage_sets_secondaryImageViewTrailingConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:8.0f];
  sut.secondaryImageViewTrailingConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  OCMVerify([constraint setConstant:0]);
}

- (void)test___setValuesDictionary___hasImage_sets_secondaryImageViewTrailingConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:8.0f];
  sut.secondaryImageViewTrailingConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellSecondaryImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

- (void)test___setValuesDictionary___noImage_sets_secondaryImageViewWidthConstraint_to_zero
{
  // given
  [self givenMockConstraintWithConstant:50.0f];
  sut.secondaryImageViewWidthConstraint = constraint;
  
  // when
  [sut setValuesDictionary:nil];
  
  // then
  OCMVerify([constraint setConstant:0]);
}

- (void)test___setValuesDictionary___hasImage_sets_secondaryImageViewWidthConstraint_to_initialValue
{
  // given
  [self givenMockConstraintWithExpecations:50.0f];
  sut.secondaryImageViewWidthConstraint = constraint;
  
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellSecondaryImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [constraint verify];
}

#pragma mark - Set Main Image - Tests

- (void)test___setValuesDictionary___ALImageCellMainImageKey
{
  // given
  [self givenMockMainImageView];
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellMainImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [[imageView verify] setImage:image];
}

- (void)test___setValuesDictionary___ALImageCellMainImageNameKey
{
  // given
  [self givenMockMainImageView];
  [self givenTestImage];
  [self swap___imageNamed___methods];
  
  NSDictionary *dict = @{ALImageCellMainImageNameKey: @"test_image"};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [[imageView verify] setImage:image];
  
  // clean up
  [self swap___imageNamed___methods];
}

#pragma mark - Set Secondary Image - Tests

- (void)test___setValuesDictionary___ALImageCellSecondaryImageKey
{
  // given
  [self givenMockSecondaryImageView];
  [self givenTestImage];
  NSDictionary *dict = @{ALImageCellSecondaryImageKey: image};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [[imageView verify] setImage:image];
}

- (void)test___setValuesDictionary___ALImageCellSecondaryImageNameKey
{
  // given
  [self givenMockSecondaryImageView];
  [self givenTestImage];
  [self swap___imageNamed___methods];
  
  NSDictionary *dict = @{ALImageCellSecondaryImageNameKey: @"test_image"};
  
  // when
  [sut setValuesDictionary:dict];
  
  // then
  [[imageView verify] setImage:image];
  
  // clean up
  [self swap___imageNamed___methods];
}


@end