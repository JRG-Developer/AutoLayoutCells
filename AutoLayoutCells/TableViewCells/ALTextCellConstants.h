//
//  ALTextCellConstants.h
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


#import "ALCellConstants.h"

/**
 *  `ALTextCell`, `ALTextFieldCell`, etc use these keys and enum to specify and format their `textView` or `textField`, respectively.
 */

/**
 *  Use a value from `ALTextCellType` to specify the desired formatting for the UITextView/UITextField.
 */
typedef NS_ENUM(NSInteger, ALTextCellType) {
  
  /**
   *  `ALTextCellTypeDefault` is the default value used if no value is specified.
   *  @discussion This auto capitalization to "sentences", sets auto correction to "default", sets the keyboard to "default", and sets spell checking to "default" system values.
   *
   */
  ALTextCellTypeDefault = 0,
  
  /**
   *  Use `ALTextCellType` to specify that the expected input is an email.
   *  @discussion This sets auto capitalization to "none", turns off auto correction, sets the keyboard to "email address", and turns off spell checking.
   */
  ALTextCellTypeEmail,
  
  /**
   *  Use `ALTextCellTypeName` to specify that the expected input is a name.
   *  @discussion This sets auto capitalization to "words", turns off auto correction, sets the keyboard to "default", and turns off spell checking.
   */
  ALTextCellTypeName,
  
  /**
   *  Use `ALTextCellTypeNoChecking` to turn off all type checking.
   *  @discussion This sets auto capitalization to "none", turns off auto correction, sets the keyboard to "default", and turns off spell checking.
   */
  ALTextCellTypeNoChecking,
  
  /**
   *  Use `ALTextCellTypeNumber` to specify that the expected input is a number.
   *  @discussion This sets auto capitalization to "none", turns off auto correction, sets the keyboard to "number pad", and turns off spell checking.
   */
  ALTextCellTypeNumber,
    
  /**
   *  Use `ALTextCellTypeDecimalNumber` to specify that the expected input is a decimal number.
   *  @discussion This sets auto capitalization to "none", turns off auto correction, sets the keyboard to "decimal pad", and turns off spell checking.
  */
  ALTextCellTypeDecimalNumber,
    
  /**
   *  Use `ALTextCellTypePassword` to specify that the expected input is a password.
   *  @discussion This sets auto capitalization to "none", turns off auto correction, sets the keyboard to "default", turns off spell checking, and turns on secure text entry.
   */
  ALTextCellTypePassword,
  
  /**
   *  Use `ALTextCellTypeSentences` to specify that the expected input is sentences.
   *  @discussion This sets auto capitalization to "sentences", turns on auto correction, sets the keyboard to "default", and turns on spell checking.
   */
  ALTextCellTypeSentences
};

/**
 *  Use this key to specify the `ALTextCellType` as an `NSNumber`.
 *
 *  @discussion The `NSNumber` object should have an integer value corresponding to a value within the `ALTextCellType` enum.
 */
extern NSString * const ALTextCellTypeKey;              // type

/**
 *  Use this key to specify the `placeholder` text.
 */
extern NSString * const ALTextCellPlaceholderTextKey;   // placeholderText
