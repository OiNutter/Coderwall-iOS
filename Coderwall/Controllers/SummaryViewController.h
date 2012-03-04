//
//  SummaryViewController.h
//  Coderwall
//
//  Created by Will on 03/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryViewController : UITableViewController
{
    NSArray *statsData;
    NSArray *sections;
}

@property NSArray *statsData;
@property NSArray *sections;

@end
