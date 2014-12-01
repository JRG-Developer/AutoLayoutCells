//
//  TextCellModel.m
//  AutoLayoutCellsDemo
//
//  Created by Anthony Miller on 12/1/14.
//
//

#import "TextCellModel.h"

@implementation TextCellModel

- (void)setValuesFromDictionary:(NSDictionary *)dictionary
{
  [super setValuesFromDictionary:dictionary];
  [self setTextFieldValueFromDictionary:dictionary];
}

- (void)setTextFieldValueFromDictionary:(NSDictionary *)dictionary
{
  NSString *value = dictionary[@"value"];
  if (value.length) {
    self.textFieldValue = value;
  }
}

@end
