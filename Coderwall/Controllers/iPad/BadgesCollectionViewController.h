//
//  BadgesCollectionViewController.h
//  Coderwall
//
//  Created by Will Mckenzie on 12/03/2014.
//  Copyright (c) 2014 Bearded Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EGORefreshTableHeaderView.h>

@interface BadgesCollectionViewController : UICollectionViewController  <EGORefreshTableHeaderDelegate>
{
    NSArray *badges;
    
    UIRefreshControl *_ios6RefreshHeaderView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
}

@property NSArray *badges;

- (void)loadData;
@end
