//
//  Model+ALCellAdapter.h
//  AutoLayoutCellsDemo
//
//  Created by Joshua Greene on 9/5/14.
//
//

#import "Model.h"

/**
 *  `Model+ALCellAdapter` is an adapter between `Model` and `AutoLayoutCells` to provide a dictionary of key-object pairs expected by `AutoLayoutCells`.
 */
@interface Model (ALCellAdapter)

/**
 *  This method returns a new dictionary with the `title`, `subtitle`, `mainImage`, and `secondaryImage` key-object pairs set.
 *
 *  @return A new dictionary with the `title`, `subtitle`, `mainImage`, and `secondaryImage` key-object pairs set.
 */
- (NSDictionary *)valuesDictionary;

@end
