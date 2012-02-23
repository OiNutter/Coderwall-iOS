//
//  StatsViewControllerViewController.h
//  Coderwall
//
//  Created by Will on 21/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsViewController : UITableViewController
{
    NSArray *statsData;
    NSArray *sections;
}

@property NSArray *statsData;
@property NSArray *sections;

@end
