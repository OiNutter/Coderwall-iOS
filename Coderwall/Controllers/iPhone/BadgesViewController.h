//
//  BadgesViewController.h
//  Coderwall
//
//  Created by Will on 19/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

{
    NSArray *badges;
    UIRefreshControl *_refreshHeaderView;
	BOOL _reloading;
}

@property NSArray *badges;

- (void)loadData;

@end
