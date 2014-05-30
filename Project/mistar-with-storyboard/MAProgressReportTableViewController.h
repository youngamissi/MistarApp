//
//  MAProgressReportTableViewController.h
//  mistar-with-storyboard
//
//  Created by Andrew Breckenridge on 5/29/14.
//  Copyright (c) 2014 Andrew Breckenridge. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MAAssignment.h"

@interface MAProgressReportTableViewController : UITableViewController

@property (nonatomic, assign) NSInteger *row;

- (id)initWithRow:(NSInteger *)row;

@end