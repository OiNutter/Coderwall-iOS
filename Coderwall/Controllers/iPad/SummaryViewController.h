//
//  SummaryViewController.h
//  Coderwall
//
//  Created by Will on 03/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface SummaryViewController : UITableViewController <EGORefreshTableHeaderDelegate>
{
    NSArray *statsData;
    NSArray *sections;
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
}

@property NSArray *statsData;
@property NSArray *sections;

- (void)loadData;

@end
