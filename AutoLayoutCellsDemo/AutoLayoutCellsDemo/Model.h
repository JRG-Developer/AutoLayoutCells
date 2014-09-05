//
//  Model.h
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

#import <Foundation/Foundation.h>

/**
 *  `Model` is a simple model class for showing how `AutoLayoutCells` works using an adapter pattern.
 *  @see `Model+ALCellAdpater`
 */
@interface Model : NSObject

///--------------------------------------------------------------
/// @name Instance Properties
///--------------------------------------------------------------

/**
 *  The title
 */
@property (strong, nonatomic) NSString *title;

/**
 *  The subtitle
 */
@property (strong, nonatomic) NSString *subtitle;

/**
 *  The main image
 */
@property (strong, nonatomic) UIImage *mainImage;

/**
 *  The secondary image
 */
@property (strong, nonatomic) UIImage *secondaryImage;

///--------------------------------------------------------------
/// @name Class Methods
///--------------------------------------------------------------

/**
 *  This is a conveience method for creating a new `Model`. 
 *
 *  @discussion This method calls `initWithDictionary`.
 *
 *  @param dictionary The dictionary to set the values of the `Model`
 *
 *  @return A new instance of `Model`
 */
+ (instancetype)modelFromDictionary:(NSDictionary *)dictionary;

///--------------------------------------------------------------
/// @name Object Lifecycle
///--------------------------------------------------------------

/**
 *  This is the designated initalizer.
 *
 *  @discussion This method calls `setValuesFromDictionary` passing the given dictionary.
 *
 *  @param dictionary The dictionary to set the values of the `Model`
 *
 *  @return A new instance of `Model`
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

///--------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------

/**
 *  This methods sets the values of the `Model` from the given dictionary.
 *
 *  @param dictionary The dictionary to set the values of the `Model`
 */
- (void)setValuesFromDictionary:(NSDictionary *)dictionary;

@end
