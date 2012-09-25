//
//  AccomplishmentsViewController.h
//  Coderwall
//
//  Created by Will on 20/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface AccomplishmentsViewController : UITableViewController <EGORefreshTableHeaderDelegate>
{
    NSArray *accomplishments;
    
	UIRefreshControl *_ios6RefreshHeaderView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    //  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}

@property NSArray *accomplishments;

- (void)loadData;

@end
