//
//  AppDelegate.m
//  AutoLayoutCellsExample
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

#import "AppDelegate.h"

#import <AutoLayoutCells/ALImageCell.h>
#import "TableViewController.h"
#import "ModelFactory.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self configureCells];
  [self setupModelsArraysOnTableViewController];
  
  return YES;
}

- (void)configureCells
{
  [[ALImageCell appearance] setLoadingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  
  // Uncomment this line for an example of using a placeholder image instead of an activity indicator
  // [[ALImageCell appearance] setSecondaryImagePlaceholder:[UIImage imageNamed:@"maneki_neko"]];
}

- (void)setupModelsArraysOnTableViewController
{
  UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
  TableViewController *tableViewController = [navController.viewControllers firstObject];
  tableViewController.models = [ModelFactory modelsFromPlistNamed:@"Models" bundle:[NSBundle mainBundle]];
  tableViewController.textModels = [ModelFactory modelsFromPlistNamed:@"TextCellModels" bundle:[NSBundle mainBundle]];
}

@end
