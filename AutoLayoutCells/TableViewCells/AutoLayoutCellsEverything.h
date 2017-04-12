//
//  AutoLayoutCellsEverything.h
//  AutoLayoutCells
//
//  Created by Joshua Greene on 7/13/14.
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

/**
 *  In general, you should import `AutoLayoutCells` *instead of* this header and then import whichever specific cell you need. However, if you really do need *all* of the table view cells and related classes, you can import this header.
 */

// Cells
#import <AutoLayoutCells/ALBooleanCell.h>
#import <AutoLayoutCells/ALCell.h>
#import <AutoLayoutCells/ALImageCell.h>
#import <AutoLayoutCells/ALLeftLabelCell.h>
#import <AutoLayoutCells/ALTextFieldCell.h>
#import <AutoLayoutCells/ALTextFieldCell.h>
#import <AutoLayoutCells/ALTextViewCell.h>
#import <AutoLayoutCells/ALTextViewOnlyCell.h>

// Constants
#import <AutoLayoutCells/ALCellConstants.h>
#import <AutoLayoutCells/ALImageCellConstants.h>
#import <AutoLayoutCells/ALLeftLabelCellConstants.h>
#import <AutoLayoutCells/ALTextCellConstants.h>

// Factories
#import <AutoLayoutCells/ALAutomaticTableViewCellFactory.h>
#import <AutoLayoutCells/ALTableViewCellFactory.h>
#import <AutoLayoutCells/ALTableViewCellNibFactory.h>

// Managers
#import <AutoLayoutCells/ALTableViewManager.h>

// Protocols
#import <AutoLayoutCells/ALCellDelegate.h>
#import <AutoLayoutCells/ALTableViewCellFactoryDelegate.h>
#import <AutoLayoutCells/ALTableViewCellFactoryProtocol.h>
#import <AutoLayoutCells/ALTextCellDelegate.h>
