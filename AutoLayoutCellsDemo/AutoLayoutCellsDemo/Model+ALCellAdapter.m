//
//  Model+ALCellAdapter.m
//  AutoLayoutCellsDemo
//
//  Created by Joshua Greene on 9/5/14.
//
//

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
