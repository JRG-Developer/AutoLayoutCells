//
//  ALTableViewCells.h
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
 *  In general, you should import this header along with whichever specific cells you need. This header gives you just the minimum imports you're likely to need.
 *
 *  You can, however, choose to import individual files one-by-one for specific needs. For example, you might want to import just `ALTableViewCellFactory` and `ALTableViewCellFactoryDelegate` if you're only custom cells created in your project.
 */

// Cells
#import <AutoLayoutCells/ALImageCell.h>

// Constants
#import <AutoLayoutCells/ALImageCellConstants.h>

// Factories
#import <AutoLayoutCells/ALTableViewCellFactory.h>
#import <AutoLayoutCells/ALTableViewCellNibFactory.h>

// Protocols
#import <AutoLayoutCells/ALCellDelegate.h>
#import <AutoLayoutCells/ALTableViewCellFactoryDelegate.h>
