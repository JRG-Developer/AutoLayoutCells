//
//  TextCellModel+ALCellAdapter.m
//  AutoLayoutCellsDemo
//
//  Created by Anthony Miller on 12/1/14.
//
//

#import "TextCellModel+ALCellAdapter.h"

#import <AutoLayoutCells/ALCellConstants.h>

@implementation TextCellModel (ALCellAdapter)

- (NSDictionary *)valuesDictionary
{
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[super valuesDictionary]];
  
  if (self.textFieldValue.length) {
    NSDictionary *textCellDict = @{ALCellValueKey: self.textFieldValue};
    
    [dict addEntriesFromDictionary:textCellDict];
  }
  
  return dict;
}

@end
