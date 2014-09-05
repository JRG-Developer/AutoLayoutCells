//
//  Model.m
//  AutoLayoutCellsDemo
//
//  Created by Joshua Greene on 9/5/14.
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

#import "Model.h"

@implementation Model

#pragma mark - Class Methods

+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary
{
  return [[self alloc] initWithDictionary:dictionary];
}

#pragma mark - Object Lifecycle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  self = [super init];
  if (self) {
    [self setValuesFromDictionary:dictionary];
  }
  return self;
}

#pragma mark - Subclass Overrides

- (NSString *)description
{
  return [NSString stringWithFormat:@"Title: %@\n"
                                    @"Subtitle: %@\n"
                                    @"Has Image Image: %@\n"
                                    @"Has Secondary Image: %@\n",
                                    self.title,
                                    self.subtitle,
                                    self.mainImage ? @"Yes" : @"No",
                                    self.secondaryImage ? @"Yes" : @"No"];
}

#pragma mark - Instance Methods

- (void)setValuesFromDictionary:(NSDictionary *)dictionary
{
  [self setTitleFromDictionary:dictionary];
  [self setSubtitleFromDictionary:dictionary];
  [self setMainImageFromDictionary:dictionary];
  [self setSecondaryImageFromDictionary:dictionary];
}

- (void)setTitleFromDictionary:(NSDictionary *)dictionary
{
  self.title = dictionary[@"title"];
}

- (void)setSubtitleFromDictionary:(NSDictionary *)dictionary
{
  self.subtitle = dictionary[@"subtitle"];
}

- (void)setMainImageFromDictionary:(NSDictionary *)dictionary
{
  NSString *name = dictionary[@"mainImageName"];

  if (name.length) {
    self.mainImage = [UIImage imageNamed:name];
  }
}

- (void)setSecondaryImageFromDictionary:(NSDictionary *)dictionary
{
  NSString *name = dictionary[@"secondaryImageName"];
  
  if (name.length) {
    self.secondaryImage = [UIImage imageNamed:name];
  }
}

@end
