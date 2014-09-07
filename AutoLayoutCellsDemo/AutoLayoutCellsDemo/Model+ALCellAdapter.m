//
//  Model+ALCellAdapter.m
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

#import "Model+ALCellAdapter.h"
#import <AutoLayoutCells/ALImageCellConstants.h>

@implementation Model (ALCellAdapter)

- (NSDictionary *)valuesDictionary
{
  NSMutableDictionary *dict = [@{ALCellTitleKey: self.title ?: @"",
                                 ALCellSubtitleKey: self.subtitle ?: @""} mutableCopy];
  
  if (self.mainImage) {
    dict[ALImageCellMainImageKey] = self.mainImage;
    
  } else if (self.mainImageURL) {
    dict[ALImageCellMainImageURLKey] = self.mainImageURL;
  }
  
  if (self.secondaryImage) {
    dict[ALImageCellSecondaryImageKey] = self.secondaryImage;
    
  } else if (self.secondaryImageURL) {
    dict[ALImageCellSecondaryImageURLKey] = self.secondaryImageURL;
  }
  
  return dict;
}

@end
