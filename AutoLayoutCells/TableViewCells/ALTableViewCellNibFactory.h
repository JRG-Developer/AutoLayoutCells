//
//  ALTableViewCellNibFactory.h
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

@import UIKit;

/**
 *  `ALTableViewCellNibFactory` makes it easy to get the `UINib` of any cell within `AutoLayoutCells`
 */
@interface ALTableViewCellNibFactory : NSObject

/**
 *  Use this method to get an `ALBooleanCell` nib
 *
 *  @return `ALBooleanCell` nib
 */
+ (UINib *)booleanCellNib;

/**
 *  Use this method to get an `ALCell` nib
 *
 *  @return `ALCell` nib
 */
+ (UINib *)cellNib;

/**
 *  Use this method to get an `ALGalleryCell` nib
 *
 *  @return `ALGalleryCell` nib
 */
+ (UINib *)galleryCellNib;

/**
 *  Use this method to get an `ALLeftLabelCell` nib
 *
 *  @return `ALLeftLabelCell` nib
 */
+ (UINib *)leftLabelCellNib;

/**
 *  Use this method to get an `ALMenuCell` nib
 *
 *  @return `ALMenuCell` nib
 */
+ (UINib *)menuCellNib;

/**
 *  Use this method to get an `ALTextCell` nib
 *
 *  @return `ALTextCell` nib
 */
+ (UINib *)textCellNib;

/**
 *  Use this method to get an `ALTextFieldCell` nib.
 *
 *  @return `ALTextFieldCell` nib
 */
+ (UINib *)textFieldCellNib;

/**
 *  Use this method to get an `ALTextOnlyCell` nib
 *
 *  @return `ALTextOnlyCell` nib
 */
+ (UINib *)textOnlyCellNib;

/**
 *  Use this method to get an table view cell instance
 *
 *  @discussion In general, you should *not* use this method to instantiate cells that will be displayed within a table view. Instead, you should use `ALTableViewCellFactory` to create cells and calculate their height.
 *
 *  This method is primarily provided for unit testing.
 *
 *  @param name  The name of the table view cell (e.g. `ALCell`, `ALTextCell`, etc)
 *  @param owner The owner of the cell (e.g. the controller instantiating the cell)
 *
 *  @return The table view cell with the given name or `nil` if not found
 */
+ (id)cellWithName:(NSString *)name owner:(id)owner;

/**
 *  Use this method to get a `UINib` with the given name within the `ALTableViewCellsBundle`.
 *
 *  @discussion All of the convience nib methods use this method to get the desired nib. In general, you should prefer using the convenience nib methods instead of this method.
 *
 *  @param name The name of the nib
 *
 *  @return The nib with the given name or `nil` if not found
 */
+ (UINib *)nibWithName:(NSString *)name;

@end
