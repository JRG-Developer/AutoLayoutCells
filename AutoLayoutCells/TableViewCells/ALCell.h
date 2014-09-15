//
//  ALCell.h
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

#import "ALBaseCell.h"
#import <ALLabel/ALLabel.h>

/**
 *  `ALCell` shows a title and subtitle. It is also the base class for most of the cells within `AutoLayoutCells`.
 *
 *  @discussion You should set the cell's values via `setValuesFromDictionary` instead of each property directly. 
 *  @see `ALCellConstants` for predefined dictionary value keys.
 */
@interface ALCell : ALBaseCell

/**
 *  The title label
 */
@property (weak, nonatomic) IBOutlet ALLabel *titleLabel;

/**
 *  The subtitle label
 */
@property (weak, nonatomic) IBOutlet ALLabel *subtitleLabel;

/**
 *  This method is called within `contentSizeCategoryDidChange:` to refresh the label's fonts.
 *
 *  @discussion The default implementation refreshes the `titleLabel` and `subtitleLabel` fonts.
 *
 *  If your cell uses custom fonts and/or has additional text, label, etc views, you should subclass and override this method. Calling `[super refreshFonts]` is allowed  but is not required.
 */
- (void)refreshFonts;

@end
