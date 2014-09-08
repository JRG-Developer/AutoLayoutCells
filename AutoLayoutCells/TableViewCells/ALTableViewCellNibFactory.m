//
//  ALTableViewCellNibFactory.m
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

#import "ALTableViewCellNibFactory.h"
#import "NSBundle+ALTableViewCellsBundle.h"

@implementation ALTableViewCellNibFactory

+ (UINib *)cellNib
{
  return [self nibWithName:@"ALCell"];
}

+ (UINib *)booleanCellNib
{
  return [self nibWithName:@"ALBooleanCell"];
}

+ (UINib *)galleryCellNib
{
  return [self nibWithName:@"ALGalleryCell"];
}

+ (UINib *)leftLabelCellNib
{
  return [self nibWithName:@"ALLeftLabelCell"];
}

+ (UINib *)menuCellNib
{
  return [self nibWithName:@"ALMenuCell"];
}

+ (UINib *)textCellNib
{
  return [self nibWithName:@"ALTextCell"];
}

+ (UINib *)textOnlyCellNib
{
  return [self nibWithName:@"ALTextOnlyCell"];
}

+ (id)cellWithName:(NSString *)name owner:(id)owner
{
  UINib *nib = [self nibWithName:name];
  UITableViewCell *view = [[nib instantiateWithOwner:owner options:nil] lastObject];
  return view;
}

+ (UINib *)nibWithName:(NSString *)name
{
  NSBundle *bundle = [NSBundle ALTableViewCellsBundle] ?: [NSBundle mainBundle];
  return [UINib nibWithNibName:name bundle:bundle];
}

@end
