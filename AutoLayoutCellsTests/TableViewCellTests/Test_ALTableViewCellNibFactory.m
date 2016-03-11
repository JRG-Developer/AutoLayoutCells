//
//  Test_ALCellNibFactory.m
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

#import "Test_ALTableViewCellNibFactory.h"

#import <objc/runtime.h>

@implementation Test_ALTableViewCellNibFactory

+ (void)load {
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self swizzleNibWithNameMethod];
  });
}

+ (void)swizzleNibWithNameMethod {
  Method m1 = class_getClassMethod([super class], @selector(nibWithName:));
  Method m2 = class_getClassMethod([super class], @selector(test_nibWithName:));
  method_exchangeImplementations(m1, m2);
}

+ (UINib *)test_nibWithName:(NSString *)name
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:name bundle:bundle];
    return nib;
}

@end
