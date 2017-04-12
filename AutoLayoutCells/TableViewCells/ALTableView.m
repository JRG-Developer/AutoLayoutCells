//
//  ALTableView.m
//  AutoLayoutCells
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

#import "ALTableView.h"
#import "UIView+ALRecursiveFirstResponder.h"

@implementation ALTableView

#pragma mark - Object Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
  self = [super initWithFrame:frame style:style];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit
{
  NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
  
  [notificationCenter addObserver:self selector:@selector(keyboardWillShow:)
                             name:UIKeyboardWillShowNotification object:nil];
  
  [notificationCenter addObserver:self selector:@selector(keyboardWillHide:)
                             name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
  UIView *firstResponder = [self AL_recursivelyFindFirstResponder];
  [self addBottomContentInset:notification firstResponder:firstResponder];
  
  UITableViewCell *cell = [self tableViewCellForFirstResponder:firstResponder];
  if (cell == nil) { return; }
  [self scrollRectToVisible:cell.frame animated:false];
}

- (void)addBottomContentInset:(NSNotification *)notification firstResponder:(UIView *)firstResponder {
  
  CGRect keyboardFrame = [self endKeyboardFrame:notification firstResponder:firstResponder];
  
  UIEdgeInsets contentInset = self.contentInset;
  contentInset.bottom = CGRectGetHeight(keyboardFrame);
  
  [self setContentInset:contentInset];
  [self setScrollIndicatorInsets:contentInset];
}

- (CGRect)endKeyboardFrame:(NSNotification *)notification firstResponder:(UIView *)firstResponder
{
  CGRect frame = CGRectZero;
  UIScreen *mainScreen = [UIScreen mainScreen];
  
  if (firstResponder.inputView) {
    frame = firstResponder.inputView.frame;
    frame.size.height += CGRectGetHeight(firstResponder.inputAccessoryView.frame);
    
  } else {
    NSDictionary *dictionary = notification.userInfo;
    frame = [dictionary[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  }
  
  frame.origin.y = CGRectGetMaxY(mainScreen.bounds) - CGRectGetHeight(frame);
  
  return frame;
}

- (UITableViewCell *)tableViewCellForFirstResponder:(UIView *)firstResponder {
  
  UIView *superview = firstResponder.superview;
  
  while (superview != nil) {
    if ([superview isKindOfClass:[UITableViewCell class]]) { return (UITableViewCell *)superview; }
    superview = superview.superview;
  }

  return nil;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  UIEdgeInsets contentInset = self.contentInset;
  contentInset.bottom = 0;
  
  [self setContentInset:contentInset];
  [self setScrollIndicatorInsets:contentInset];
}

@end
